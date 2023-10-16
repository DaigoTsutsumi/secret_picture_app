import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secret_picture2_app/model/folder.dart';

part 'folder_view_state.freezed.dart';

@freezed
abstract class FolderViewState with _$FolderViewState {
  const factory FolderViewState({
    @Default([]) List<Folder> folders,
    @Default([]) List<String> images,
    required String name,
  }) = _FolderViewState;
}
