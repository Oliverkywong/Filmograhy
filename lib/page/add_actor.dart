import 'package:flutter/material.dart';
import 'package:filmography/models/film.dart';

class CreateList extends StatefulWidget {
  final FilmTable? film;
  final ValueChanged<String> onSubmit;

  const CreateList({Key? key, this.film, required this.onSubmit})
      : super(key: key);
  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final controllor = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controllor.text = widget.film?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.film != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit': 'Add'),
      content: Form(
        key: formKey,
        child: TextFormField(
          autofocus: true,
          controller: controllor,
          decoration: const InputDecoration(hintText: 'name'),
          validator: (value)=> value != null && value.isEmpty ? 'name is required' : null,
        ),
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('cancel')),
        TextButton(onPressed: () {
          if(formKey.currentState!.validate()){
            widget.onSubmit(controllor.text);
          }
        }, child: const Text('OK')),
      ],
    );
  }
}