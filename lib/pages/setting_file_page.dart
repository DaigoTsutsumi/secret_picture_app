import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';

class SettingFile extends StatefulWidget {
  SettingFile(this.id, {Key? key}) : super(key: key);
  String id;

  @override
  State<SettingFile> createState() => _SettingFileState();
}

class _SettingFileState extends State<SettingFile> {
  TextEditingController controller = TextEditingController();

//削除のコード
  Future<void> deleteFolder(String docId) async {
    var document = FirebaseFirestore.instance.collection('folder').doc(docId);
    document.delete();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('フォルダ編集'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _delete(context, widget.id),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Form(
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
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await FolderFirestore.updateNameFolder(
                        widget.id, controller.text);
                    if (result) {
                      controller.clear();
                      int count = 0;
                      Navigator.of(context).popUntil((route) => count++ >= 1);
                    }
                    print(controller.text);
                  }
                  //todo 処理書く
                },
                child: Text('保存'
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
            AlertDialog(title: Text("削除してよろしいでしょうか"), actions: <Widget>[
              SimpleDialogOption(
                child: Text("YES"),
                onPressed: () async {
                  await deleteFolder(id);
                  //todo フォルダ内の画像を削除する処理
                  int count = -1;
                  Navigator.of(context).popUntil((route) => count++ >= 2);
                  // Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text("NO"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]));
  }
}
