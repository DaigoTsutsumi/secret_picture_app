import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required String folderId,
    Timestamp? createdAt,
    required List<String> imagePathList,
    required String name,
  }) = _Folder;
}
