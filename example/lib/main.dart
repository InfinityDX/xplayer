import 'package:flutter/material.dart';
import 'package:xplayer_example/pages/general_page.dart';
import 'package:xplayer_example/pages/shorts_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: GeneralPage(),
      home: ShortsPage(),
    );
  }
}
