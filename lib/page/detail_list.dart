import 'package:flutter/material.dart';
import 'package:filmography/page/detail.dart';

class DetailList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailListState();
  }
}

class DetailListState extends State<DetailList> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("List"),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('flatonclick');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Detail('Add');
          }));
        },
        tooltip: 'Add data',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://picsum.photos/id/237/200/300')),
              title: Text(
                'dummy',
                style: titleStyle,
              ),
              subtitle: Text('date'),
              onTap: () {
                debugPrint('onclick');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Detail('Edit');
                }));
              },
            ),
          );
        });
  }
}


