import 'package:filmography/database/film_db.dart';
import 'package:filmography/models/film.dart';
import 'package:filmography/page/films_page.dart';
import 'package:flutter/material.dart';
import 'package:filmography/page/add_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<FilmTable>>? actor;
  final filmDB = FilmDB();

  void fetchAll() {
    setState(() {
      actor = filmDB.showActor();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onSubmitted: (String value) {
            setState(() {
              actor = filmDB.find(value);
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddPage('Add');
              }));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Text Color
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              fetchAll();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Text Color
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<FilmTable>>(
        future: actor,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final film = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: film.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(film[index].actor),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FilmsPage(film[index].actor);
                    }));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
        },
      ),
    );
  }
}
