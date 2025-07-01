import 'dart:io';
import 'package:flutter/material.dart';
import '../models/upload_image_model.dart';
import '../services/upload_service.dart';

class ImageUploadProvider extends ChangeNotifier {
  final List<UploadImageModel> _images = [];

  List<UploadImageModel> get images => _images;

  /// Add new image to memory (RAM)
  void addImage(File imageFile) {
    _images.add(UploadImageModel(imageFile: imageFile));
    notifyListeners();
  }

  /// Upload all pending or failed images
  Future<void> uploadPendingImages() async {
    for (var img in _images) {
      if (img.status == UploadStatus.Pending || img.status == UploadStatus.Failed) {
        await _uploadImage(img);
      }
    }
  }

  /// Retry single image upload
  Future<void> retryUpload(UploadImageModel img) async {
    await _uploadImage(img);
  }

  /// Upload logic
  Future<void> _uploadImage(UploadImageModel img) async {
    img.status = UploadStatus.Uploading;
    notifyListeners();

    final success = await UploadService.uploadImage(img.imageFile);

    img.status = success ? UploadStatus.Success : UploadStatus.Failed;
    notifyListeners();
  }
}
