import 'package:cloud_firestore/cloud_firestore.dart';

class Folder {
  String folderId;
  Timestamp? createdAt;
  List<String> imagePathList;
  String name;

  Folder({
    required this.folderId,
    this.createdAt,
    required this.imagePathList,
    required this.name,
  });
}
