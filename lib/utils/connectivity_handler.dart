import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/image_upload_provider.dart';

class ConnectivityHandler {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static void initialize(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final isConnected = results.any((r) => r != ConnectivityResult.none);

      if (isConnected) {
        print("📶 Internet Restored → Auto uploading pending images...");
        Provider.of<ImageUploadProvider>(context, listen: false).uploadPendingImages();
      }
    });
  }

  static void dispose() {
    _subscription?.cancel();
  }
}
