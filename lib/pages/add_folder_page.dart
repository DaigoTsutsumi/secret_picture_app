import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';

class AddFile extends ConsumerStatefulWidget {
  const AddFile({Key? key}) : super(key: key);

  @override
  AddFileState createState() => AddFileState();
}

TextEditingController controller = TextEditingController();

class AddFileState extends ConsumerState<AddFile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('フォルダ追加'),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FolderFirestore.createFolder(controller.text);
                    print(controller.text);
                    controller.clear();
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 1);
                  }
                },
                child: Text('保存'))
          ],
        ),
      ),
    );
  }
}
