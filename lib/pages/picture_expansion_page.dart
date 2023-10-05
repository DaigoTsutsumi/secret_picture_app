import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/view_model/folder_view_model.dart';

class PictureExpansion extends ConsumerStatefulWidget {
  const PictureExpansion(this.folderId, this.imagePath, {super.key});
  final String folderId;
  final String imagePath;

  @override
  ConsumerState<PictureExpansion> createState() => _PictureExpansionState();
}

class _PictureExpansionState extends ConsumerState<PictureExpansion> {
  @override
  build(BuildContext context) {
    final state = ref.watch(folderViewModelProvider);
    final folderNotifier = ref.read(folderViewModelProvider.notifier);

    void _delete(BuildContext context) async {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(title: Text("削除してよろしいでしょうか"), actions: <Widget>[
                SimpleDialogOption(
                  child: Text("YES"),
                  onPressed: () async {
                    await folderNotifier.deleteImagePath(
                      folderId: widget.folderId,
                      image: widget.imagePath,
                    );
                    int count = 0;
                    if (context.mounted) {
                      Navigator.of(context).popUntil((route) => count++ >= 2);
                    }
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
}
