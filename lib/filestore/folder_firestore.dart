import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secret_picture2_app/model/folder.dart';
import 'package:secret_picture2_app/utils/shared_prefs.dart';

class FolderFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _folderCollection =
      _firebaseFirestoreInstance.collection('folder');

  /// 全フォルダ取得するメソッド
  static Future<List<Folder>?> getAllFolder() async {
    try {
      final collection = await _folderCollection
          .where('user_id', isEqualTo: SharedPrefs.fetchUid())
          .get();
      final folders = collection.docs
          .map((doc) => Folder(
                folderId: doc.id,
                name: doc['name'],
                imagePathList:
                    doc['image_path_list'].cast<String>() as List<String>,
                createdAt: doc['created_time'],
              ))
          .toList();
      return folders;
    } catch (e) {
      print(e);
      print('エラー');
    }
    return null;
  }

  static Future<List<Folder>?> getImages() async {
    try {
      final collection = await _folderCollection
          .where('user_id', isEqualTo: SharedPrefs.fetchUid())
          .get();
      final folders = collection.docs
          .map((doc) => Folder(
                folderId: doc.id,
                name: doc['name'],
                imagePathList:
                    doc['image_path_list'].cast<String>() as List<String>,
                createdAt: doc['created_time'],
              ))
          .toList();
      return folders;
    } catch (e) {
      print(e);
      print('エラー');
    }
    return null;
  }

  // フォルダ追加
  static Future<void> createFolder(String name) async {
    try {
      await _folderCollection.add({
        'image_path_list': [], //storageの画像パス
        'created_time': Timestamp.now(),
        'user_id': SharedPrefs.fetchUid(),
        'name': name, //ここにファイルの名前を書き込み
      });
    } catch (e) {
      print('ファイルの作成失敗　＝＝＝＝＝　$e');
    }
  }

  static Future<bool> updateNameFolder(String id, String name) async {
    try {
      await _folderCollection.doc(id).update({
        'name': name, //ここにファイルの名前を書き込み
      });
      return true;
    } catch (e) {
      print(e);
      print('エラー');
    }
    return false;
  }

  // 画像追加
  static Future<void> updateFolder(
      String id, List<String> imagePathList) async {
    try {
      await _folderCollection.doc(id).set(
        {
          'image_path_list': imagePathList, //storageの画像パス
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('ファイルの作成失敗　＝＝＝＝＝　$e');
    }
  }

  // 画像削除
  static Future<void> deleteImagePath(
    String docId,
    String imagePath,
  ) async {
    await _folderCollection.doc(docId).update({
      'image_path_list': FieldValue.arrayRemove([imagePath])
    });
  }
}
