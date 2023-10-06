import 'package:flutter/material.dart';
import 'package:filmography/database/film_db.dart';

class AddPage extends StatefulWidget {
  String pageTitle;
  AddPage(this.pageTitle, {super.key});
  @override
  State<StatefulWidget> createState() {
    return AddPageState(this.pageTitle);
  }
}

class AddPageState extends State<AddPage> {
  String pageTitle;
  AddPageState(this.pageTitle);
  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController actorController = TextEditingController();
  final filmDB = FilmDB();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;
    final ButtonStyle btnstyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: TextField(
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('text');
                },
                decoration: InputDecoration(
                    label: Text('name'),
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: TextField(
                controller: yearController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('textyear');
                },
                decoration: InputDecoration(
                    label: Text('year'),
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            pageTitle == 'Add'
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: TextField(
                      controller: actorController,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('textactor');
                      },
                      decoration: InputDecoration(
                          label: Text('actor'),
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    style: btnstyle,
                    onPressed: () async {
                      await filmDB.add(
                          name: nameController.text,
                          year: yearController.text,
                          actor: actorController.text);
                      Navigator.pop(context);
                    },
                    child: Text('save'),
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ElevatedButton(
                    style: btnstyle,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('delete'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
