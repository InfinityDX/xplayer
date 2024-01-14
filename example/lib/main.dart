import 'package:flutter/material.dart';
import 'package:xplayer_example/pages/general_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: Placeholder(),
      home: GeneralPage(),
      // home: ShortsPage(),
    );
  }
}
