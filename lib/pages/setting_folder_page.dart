import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/view_model/folder_view_model.dart';

class SettingFolderPage extends ConsumerStatefulWidget {
  SettingFolderPage(this.id, this.name, {Key? key}) : super(key: key);
  String id;
  String name;

  @override
  ConsumerState<SettingFolderPage> createState() => _SettingFileState();
}

class _SettingFileState extends ConsumerState<SettingFolderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

//削除のコード
  Future<void> deleteFolder(String docId) async {
    var document = FirebaseFirestore.instance.collection('folder').doc(docId);
    document.delete();
  }

  @override
  Widget build(BuildContext context) {
    final folderNotifier = ref.read(folderViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('フォルダ編集'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _delete(context, widget.id),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'テキストを入力してください';
                  }
                },
                controller: controller,
                onChanged: (value) {
                  print(value);
                  print(controller);
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await folderNotifier.updateTitleText(
                        widget.id, controller.text);
                    if (result) {
                      controller.clear();
                      int count = 0;
                      Navigator.of(context).popUntil((route) => count++ >= 1);
                    }
                    print(controller.text);
                  }
                },
                child: const Text('保存'
                    ''))
          ],
        ),
      ),
    );
  }

  void _delete(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: const Text("削除してよろしいでしょうか"), actions: <Widget>[
              SimpleDialogOption(
                child: const Text("YES"),
                onPressed: () async {
                  await deleteFolder(id);
                  int count = -1;
                  if (context.mounted) {
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  }
                  // Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: const Text("NO"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]));
  }
}
