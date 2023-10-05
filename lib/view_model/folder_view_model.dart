import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';
import 'package:secret_picture2_app/model/folder.dart';
import 'package:secret_picture2_app/state/folder_view_state.dart';
import 'package:secret_picture2_app/utils/shared_prefs.dart';

final folderViewModelProvider =
    StateNotifierProvider<FolderStateNotifier, FolderViewState>(
        (ref) => FolderStateNotifier());

class FolderStateNotifier extends StateNotifier<FolderViewState> {
  FolderStateNotifier() : super(const FolderViewState());

  Future<List<Folder>?> getAllFolder() async {
    final folders = await FolderFirestore.getAllFolder();
    if (folders != null) {
      updateFolders(folders);
    }
    return folders;
  }

  Future<void> uploadImage(
      {required String folderId, required List<File> images}) async {
    try {
      List<String> imagePathList = [];
      imagePathList.addAll([...?state.images]);
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
      print('あああ${imagePathList}');
      await FolderFirestore.updateFolder(folderId, imagePathList);
      updateImages(imagePathList);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteImagePath(
      {required String folderId, required String image}) async {
    await FolderFirestore.deleteImagePath(folderId, image);
    List<String> tmpImages = List.from(state.images!);
    tmpImages.remove(image);
    updateImages(tmpImages);
  }

  void updateFolders(List<Folder> folders) {
    state = state.copyWith(folders: folders);
  }

  void updateImages(List<String> images) {
    state = state.copyWith(images: images);
  }

  //void removeImages(List<String> images) {
  //state = state.where((image) => image.id != id).toList();}
}
