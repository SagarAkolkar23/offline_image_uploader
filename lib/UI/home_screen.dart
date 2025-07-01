import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/upload_image_model.dart';
import '../state/image_upload_provider.dart';

class HomeScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      final provider = Provider.of<ImageUploadProvider>(context, listen: false);
      for (var image in images) {
        provider.addImage(File(image.path));
      }
      await provider.uploadPendingImages();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offline Image Uploader"),
        backgroundColor: Colors.indigo,
      ),
      body: Consumer<ImageUploadProvider>(
        builder: (context, provider, _) {
          final images = provider.images;

          return Padding(
              padding: const EdgeInsets.all(12.0),
          child: images.isEmpty
          ? Center(
          child: Text(
          "No images selected.\nTap + to add one.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          )
              : ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
          final img = images[index];
          return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: ListTile(
          leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
          img.imageFile,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          ),
          ),
          title: Text(
          img.imageFile.path.split('/').last,
          overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
          _getStatusText(img.status),
          style: TextStyle(color: _getStatusColor(img.status)),
          ),
          trailing: img.status == UploadStatus.Failed
          ? IconButton(
          icon: Icon(Icons.refresh, color: Colors.red),
          onPressed: () => provider.retryUpload(img),
          )
              : _getStatusIcon(img.status),
          ),
          );
          },
          )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickImage(context),
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add_a_photo),
        tooltip: "Pick Image",
      ),
    );
  }

  String _getStatusText(UploadStatus status) {
    switch (status) {
      case UploadStatus.Pending:
        return "Pending (waiting for internet)";
      case UploadStatus.Uploading:
        return "Uploading...";
      case UploadStatus.Success:
        return "Uploaded successfully";
      case UploadStatus.Failed:
        return "Upload failed";
      default:
        return "";
    }
  }

  Color _getStatusColor(UploadStatus status) {
    switch (status) {
      case UploadStatus.Pending:
        return Colors.orange;
      case UploadStatus.Uploading:
        return Colors.blueAccent;
      case UploadStatus.Success:
        return Colors.green;
      case UploadStatus.Failed:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Widget? _getStatusIcon(UploadStatus status) {
    switch (status) {
      case UploadStatus.Success:
        return Icon(Icons.check_circle, color: Colors.green);
      case UploadStatus.Uploading:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case UploadStatus.Pending:
        return Icon(Icons.hourglass_bottom, color: Colors.orange);
      default:
        return null;
    }
  }
}
