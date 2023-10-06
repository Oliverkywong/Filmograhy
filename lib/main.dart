import 'package:flutter/material.dart';
import 'package:filmography/page/home_page.dart';
import 'package:sqflite/sqflite.dart';

Future  main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Filmography App',
      home: MyHomePage(),
    );
  }
}

