import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';
import 'package:secret_picture2_app/model/folder.dart';
import 'package:secret_picture2_app/pages/setting_file_page.dart';
import 'package:secret_picture2_app/utils/shared_prefs.dart';

import 'picture_expansion_page.dart';

class PictureFile extends StatefulWidget {
  PictureFile(this.folder, {Key? key}) : super(key: key);
  Folder folder;

  @override
  State<PictureFile> createState() => _PictureFileState();
}

class _PictureFileState extends State<PictureFile> {
  File? image;
  List<String> imagePathList = [];
  final ImagePicker _picker = ImagePicker();

  TextEditingController controller = TextEditingController();

//削除のコード
  Future<void> deleteFolder(String docId) async {
    var document = FirebaseFirestore.instance.collection('name').doc(docId);
    document.delete();
  }

  Future<List<File>> selectImage() async {
    List<File> images = [];
    List<XFile> pickedImages = await _picker.pickMultiImage();
    print(pickedImages);
    if (pickedImages.isNotEmpty) {
      for (final image in pickedImages) {
        final pickedImage = File(image.path);
        images.add(pickedImage);
      }
    }
    return images;
  }

  Future<void> uploadImage(String folderId, List<File> images) async {
    try {
      String? uid = SharedPrefs.fetchUid();
      final firebaseStorage = FirebaseStorage.instance;
      for (var image in images) {
        String tempPath = image.path.substring(image.path.lastIndexOf('/') + 1);
        String path = "users/$uid/$folderId/$tempPath";
        final ref = firebaseStorage.ref(path);
        final storedImage = await ref.putFile(image);
        final imagePath = await storedImage.ref.getDownloadURL();
        imagePathList.add(imagePath);
      }
      await FolderFirestore.updateFolder(folderId, imagePathList);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.folder.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingFile(widget.folder.folderId)));
                print('設定画面');
              },
            ),
          ],
          centerTitle: true,
        ),
        body: widget.folder.imagePathList.isEmpty
            ? const Center(
                child: Text(
                '写真を追加してください',
              ))
            : GridView.builder(
                itemCount: widget.folder.imagePathList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureExpansion(
                                  widget.folder.folderId,
                                  widget.folder.imagePathList[index])));
                      print(widget.folder.imagePathList);
                    },
                    child: Image.network(widget.folder.imagePathList[index]),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final images = await selectImage();
            if (images.isNotEmpty) {
              await uploadImage(widget.folder.folderId, images);
            }
          },

          ///・右下のボタンからOSのアルバムの画像をフォルダに追加
          //uplordImage()///　・FirebaseのStorageに追加
          ///　・表示中のfolderドキュメントIDに情報を更新
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
