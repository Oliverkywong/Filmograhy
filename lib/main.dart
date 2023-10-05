import 'package:flutter/material.dart';
import 'package:filmography/page/films_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmograhy App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: FilmsPage(),
    );
  }
}



// import 'package:filmography/page/home_page.dart';
//
// void main() => runApp(const AppBarApp());
//
// class AppBarApp extends StatelessWidget {
//   const AppBarApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Filmography App',
//       home: MyHomePage(title: 'Filmography App'),
//     );
//   }
// }

