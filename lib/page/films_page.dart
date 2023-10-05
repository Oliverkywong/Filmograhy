import 'package:filmography/database/film_db.dart';
import 'package:filmography/models/film.dart';
import 'package:filmography/page/add_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmsPage extends StatefulWidget {
  const FilmsPage({super.key});
  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  Future<List<FilmTable>>? futureFilm;
  final filmDB = FilmDB();

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  void fetchAll() {
    setState(() {
      futureFilm = filmDB.showAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Filmography'),
        ),
        body: FutureBuilder<List<FilmTable>>(
          future: futureFilm,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final film = snapshot.data!;
              return film.isEmpty
                  ? const Center(
                      child: Text('No films..'),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final fil = film[index];
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: film.length);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => CreateList(onSubmit: (name) async {
                      await filmDB.add(name: name, year: 2000, actor: '');
                      if (!mounted) return;
                      fetchAll();
                      Navigator.of(context).pop();
                    }));
          },
        ),
      );
}
