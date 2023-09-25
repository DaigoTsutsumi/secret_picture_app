import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';
import 'package:secret_picture2_app/main.dart';

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
    //  `ref` は StatefulWidget のすべてのライフサイクルメソッド内で使用可能です。
    ref.read(myHomePageProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final Function increment = ref.read(myHomePageProvider.notifier).increment;
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
                  increment();
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
