import 'dart:io';

enum UploadStatus { Pending, Uploading, Success, Failed }

class UploadImageModel {
  final File imageFile;
  UploadStatus status;

  UploadImageModel({
    required this.imageFile,
    this.status = UploadStatus.Pending,
  });
}
