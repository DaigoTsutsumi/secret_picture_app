import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secret_picture2_app/model/user.dart';
import 'package:secret_picture2_app/utils/shared_prefs.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  /// FireStoreにUserを追加
  static Future<String?> insertNewAccount() async {
    try {
      final newDoc = await _userCollection.add({
        'created_time': Timestamp.now(),
      });

      updateUserId(newDoc.id);
      print('アカウント完了');
      return newDoc.id;
    } catch (e) {
      print('アカウント作成失敗　＝＝＝＝＝　$e');
      return null;
    }
  }

  static Future<void> createUser() async {
    final myUid = await insertNewAccount();
    if (myUid != null) {
      await SharedPrefs.setUid(myUid);
      //端末にユーザーIDを保存
    }
  }

  /// ユーザーを取得する
  static Future<List<QueryDocumentSnapshot>?> fetchUsers() async {
    try {
      final snapshot = await _userCollection.get();
      return snapshot.docs;
    } catch (e) {
      print('ユーザー情報の取得失敗　＝＝＝＝＝　$e');
      return null;
    }
  }

  static Future<void> updateUserId(String id) async {
    try {
      _userCollection.doc(id).update({
        'uid': id,
      });
    } catch (e) {
      print('ユーザー情報の更新失敗　===== $e');
    }
  }

  static Future<User?> fetchProfile(String uid) async {
    try {
      DateTime createdAt = DateTime.now();
      Timestamp createdAtTimestamp = Timestamp.fromDate(createdAt);
      final snapshot = await _userCollection.doc(uid).get();
      User user = User(uid: snapshot.data()!['uid']);

      return user;
    } catch (e) {
      print('自分のユーザー情報の取得失敗 ----- $e');
      return null;
    }
  }
}
