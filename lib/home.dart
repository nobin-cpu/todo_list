import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:todo_list/add_contacts.dart';
import 'package:todo_list/db_helper.dart';
import 'package:todo_list/models/contacts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local database'),
      ),
      body: FutureBuilder<List<Contacts>>(
          future: DBHelper.readContacts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contacts>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loaading")
                  ],
                ),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('no data'),
                  )
                : ListView(
                    children: snapshot.data!.map((e) {
                    return Center(
                      child: ListTile(
                        title: Text('${e.name}'),
                        subtitle: Text('${e.address}'),
                      ),
                    );
                  }).toList());
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final refreash = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Addcontacts()));
          },
          child: Icon(Icons.add)),
    );
  }
}
