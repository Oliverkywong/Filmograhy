import 'package:flutter/material.dart';
import 'package:filmography/models/film.dart';

class CreateList extends StatefulWidget {
  final FilmTable? film;
  final ValueChanged<List> onSubmit;

  const CreateList({Key? key, this.film, required this.onSubmit})
      : super(key: key);
  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final namecontrollor = TextEditingController();
  final yearcontrollor = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    namecontrollor.text = widget.film?.name ?? '';
    yearcontrollor.text = widget.film?.year ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.film != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit' : 'Add'),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              controller: namecontrollor,
              decoration: const InputDecoration(hintText: 'name'),
              validator: (value) =>
                  value != null && value.isEmpty ? 'name is required' : null,
            ),
            TextFormField(
              autofocus: true,
              controller: yearcontrollor,
              decoration: const InputDecoration(hintText: 'year'),
              validator: (value) =>
                  value != null && value.isEmpty ? 'year is required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('cancel')),
        TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.onSubmit([namecontrollor.text, yearcontrollor.text]);
              }
            },
            child: const Text('OK')),
      ],
    );
  }
}
