import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_picture2_app/model/folder.dart';
import 'package:secret_picture2_app/pages/setting_folder_page.dart';
import 'package:secret_picture2_app/view_model/folder_view_model.dart';

import 'picture_expansion_page.dart';

class PictureFolderPage extends ConsumerWidget {
  PictureFolderPage(this.folder, {super.key});

  File? image;
  Folder folder;
  final ImagePicker _picker = ImagePicker();

  @override
  build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(folderViewModelProvider);
    final folderNotifier = ref.read(folderViewModelProvider.notifier);

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

    return Scaffold(
        appBar: AppBar(
          title: Text(state.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingFolderPage(folder.folderId, state.name)));
                print('セッティング画面');
              },
            ),
          ],
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await folderNotifier
                .loadData(folderId: '', images: []); // データを再読み込みするメソッドを実行
          },
          child: state.images.isEmpty

              ///future: folderNotifier.getImages(),
              ? const Center(
                  child: Text(
                  '写真を追加してください',
                ))
              : GridView.builder(
                  itemCount: state.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PictureExpansionPage(
                                    folder.folderId, state.images[index])));
                        print(state.images);
                      },
                      child: Image.network(state.images[index]),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final images = await selectImage();
            if (images.isNotEmpty) {
              await folderNotifier.uploadImage(
                folderId: folder.folderId,
                images: images,
              );
            }
          },

          ///・右下のボタンからOSのアルバムの画像をフォルダに追加
          //uplordImage()///　・FirebaseのStorageに追加
          ///　・表示中のfolderドキュメントIDに情報を更新
          child: const Icon(Icons.add),
        ));
  }
}
