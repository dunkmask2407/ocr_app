import 'package:flutter/material.dart';
import 'package:ocr_app/controllers/camera_screen.dart';
// import 'package:ocr_app/controllers/extraction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      /* theme: ThemeData(
        primaryColor: Colors.black
      ), */
      home: const CameraScreen(),
      // home: const ExtractionScreen(text: 'Hello World'),
      debugShowCheckedModeBanner: false,
    );
  }
}
