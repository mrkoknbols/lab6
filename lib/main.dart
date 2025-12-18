import 'package:flutter/material.dart';
import 'screens/apod_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA APOD',
      theme: ThemeData.dark(),
      home: const APODScreen(),
    );
  }
}