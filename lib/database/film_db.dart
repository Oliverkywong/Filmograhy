import 'package:sqflite/sqflite.dart';
import 'package:filmography/models/film.dart';
import 'package:filmography/database/database_service.dart';

class FilmDB {
  final tableName = 'filmography';
  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    "actor" TEXT NOT NULL,
    PRIMARY KEY ("id" AUTOINCREMENT));""");
  }

  Future<int> add(
      {required String name,
      required String year,
      required String actor}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        """INSERT INTO $tableName (name, year, actor) VALUES (?, ? ,?);""",
        [name, year, actor]);
  }

  Future<List<FilmTable>> showActor() async {
    final database = await DatabaseService().database;
    final films =
        await database.rawQuery("""SELECT * FROM $tableName GROUP BY actor;""");
    return films.map((film) => FilmTable.fromSqflileDatabase(film)).toList();
  }

  Future<List<FilmTable>> showActorFilm(String actor) async {
    final database = await DatabaseService().database;
    final films = await database
        .rawQuery("""SELECT * FROM $tableName WHERE actor = ?;""", [actor]);
    return films.map((film) => FilmTable.fromSqflileDatabase(film)).toList();
  }

  Future<List<FilmTable>> find(String search) async {
    final database = await DatabaseService().database;
    final films = await database.rawQuery(
        """SELECT * FROM $tableName WHERE actor LIKE '%$search%';""");
    print(films);
    return films.map((film) => FilmTable.fromSqflileDatabase(film)).toList();
  }

  Future<int> update({required int id, String? name, String? year}) async {
    final database = await DatabaseService().database;
    return await database.update(tableName, {'name': name, 'year': year},
        where: 'id=?',
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete("""DELETE FROM $tableName WHERE id = ?""", [id]);
  }
}
