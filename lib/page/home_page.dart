import 'package:flutter/material.dart';
import 'package:filmography/page/detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> actor = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Detail('Add');
              }));
            },
            child: const Text('Add'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Text Color
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: actor.length,
        itemBuilder: (BuildContext context, int index) {
          // return Container(
          //   height: 50,
          //   child: Center(child: Text('${actor[index]}')),
          // );
          return ListTile(
            title: Text('${actor[index]}'),
            onTap: () {

              var snackBar = SnackBar(content: Text("Tapped on ${actor[index]}"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}