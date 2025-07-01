import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../utils/notification_service.dart';

class UploadService {
  static Future<bool> uploadImage(File imageFile) async {
    try {
      // Use a mock API (change this to your own if needed)
      final uri = Uri.parse("https://httpbin.org/post");

      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        filename: basename(imageFile.path),
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        print("✅ Upload successful");
        await NotificationService.showUploadSuccessNotification(imageFile.path.split('/').last);
        return true;
      } else {
        print("❌ Upload failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Upload exception: $e");
      return false;
    }
  }
}
