import 'package:flutter/material.dart';
import 'package:todo_list/db_helper.dart';
import 'package:todo_list/models/contacts.dart';

class Addcontacts extends StatefulWidget {
  const Addcontacts({super.key, this.contacts});
  final Contacts? contacts;
  @override
  State<Addcontacts> createState() => _AddcontactsState();
}

class _AddcontactsState extends State<Addcontacts> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.contacts != null) {
        _nameController.text = widget.contacts!.name!;
        _contactsController.text = widget.contacts!.address!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit anything'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildtextfield(_nameController, 'name'),
            SizedBox(
              height: 10,
            ),
            _buildtextfield(_contactsController, 'address'),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              //this button is pressed to add contact
              onPressed: () async {
                //if contact has data, then update existing list
                //according to id
                //else create a new contact
                if (widget.contacts != null) {
                  await DBHelper.updateContacts(Contacts(
                    id: widget.contacts!.id, //have to add id here
                    name: _nameController.text,
                    address: _contactsController.text,
                  ));

                  Navigator.of(context).pop(true);
                } else {
                  await DBHelper.openContact(Contacts(
                    name: _nameController.text,
                    address: _contactsController.text,
                  ));

                  Navigator.of(context).pop(true);
                }
              },
              child: Text('Add to Contact List'),
            ),
          ],
        ),
      ),
    );
  }
}

TextField _buildtextfield(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}
