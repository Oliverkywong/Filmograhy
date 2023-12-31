class FilmTable {
  final int id;
  final String name;
  final String year;
  final String actor;

  const FilmTable({
    required this.id,
    required this.name,
    required this.year,
    required this.actor,
  });
  factory FilmTable.fromSqflileDatabase(Map<String, dynamic> map) => FilmTable(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        year: map['year'] ?? '',
        actor: map['actor'] ?? '',
      );
}
