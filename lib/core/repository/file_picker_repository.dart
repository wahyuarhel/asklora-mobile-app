import 'package:file_picker/file_picker.dart';

class FilePickerRepository {
  Future<PlatformFile?> pickFile({FileType fileType = FileType.any}) async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: fileType,
    );
    if (filePickerResult != null) {
      return filePickerResult.files.single;
    } else {
      return null;
    }
  }

  Future<List<PlatformFile>> pickFiles(
      {FileType fileType = FileType.any}) async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: fileType,
    );
    if (filePickerResult != null) {
      return filePickerResult.files;
    } else {
      return [];
    }
  }
}
