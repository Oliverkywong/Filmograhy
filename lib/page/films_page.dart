import 'package:filmography/database/film_db.dart';
import 'package:filmography/models/film.dart';
import 'package:filmography/page/add_film.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmsPage extends StatefulWidget {
  String pageTitle;
  FilmsPage(this.pageTitle, {super.key});
  @override
  State<StatefulWidget> createState() {
    return FilmsPageState(this.pageTitle);
  }
}

class FilmsPageState extends State<FilmsPage> {
  String pageTitle;
  FilmsPageState(this.pageTitle);
  Future<List<FilmTable>>? futureFilm;
  final filmDB = FilmDB();

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  void fetchAll() {
    setState(() {
      futureFilm = filmDB.showActorFilm(pageTitle);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('$pageTitle Filmography'),
        ),
        body: FutureBuilder<List<FilmTable>>(
          future: futureFilm,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final film = snapshot.data!;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final fil = film[index];
                    return ListTile(
                      title: Text(fil.name),
                      subtitle: Text(fil.year),
                      trailing: IconButton(
                        onPressed: () async {
                          await filmDB.delete(fil.id);
                          fetchAll();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => CreateList(
                                film: fil,
                                onSubmit: (list) async {
                                  await filmDB.update(
                                      id: fil.id, name: list[0], year: list[1]);
                                  fetchAll();
                                  if (!mounted) return;
                                  Navigator.of(context).pop();
                                }));
                      },
                    );
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
                builder: (_) => CreateList(onSubmit: (list) async {
                      await filmDB.add(
                          name: list[0], year: list[1], actor: pageTitle);
                      if (!mounted) return;
                      fetchAll();
                      Navigator.of(context).pop();
                    }));
          },
        ),
      );
}
