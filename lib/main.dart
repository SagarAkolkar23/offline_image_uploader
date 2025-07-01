import 'package:flutter/material.dart';
import 'package:offline_image_uploader/utils/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'services/upload_service.dart';
import 'state/image_upload_provider.dart';
import 'ui/home_screen.dart';
import 'utils/connectivity_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
      ],
      child: Builder(
        builder: (context) {
          // 👇 Start connectivity listener
          ConnectivityHandler.initialize(context);

          return MaterialApp(
            title: 'Offline Image Uploader',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
