import 'package:flutter/material.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';

class PictureExpansion extends StatefulWidget {
  const PictureExpansion(this.folderId, this.imagePath, {Key? key})
      : super(key: key);
  final String folderId;
  final String imagePath;

  @override
  State<PictureExpansion> createState() => _PictureExpansionState();
}

class _PictureExpansionState extends State<PictureExpansion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _delete(context),
          ),
        ],
      ),
      body: Center(
          child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.network(widget.imagePath))),
    );
  }

  void _delete(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Text("削除してよろしいでしょうか"), actions: <Widget>[
              SimpleDialogOption(
                child: Text("YES"),
                onPressed: () async {
                  await FolderFirestore.deleteImagePath(
                      widget.folderId, widget.imagePath);
                  //todo フォルダ内の画像を削除する処理
                  int count = 0;
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
