import 'package:contact_manager/pages/new_contact.dart';
import 'package:flutter/material.dart';

class ContactHome extends StatelessWidget {
  const ContactHome({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewContact.routeName),
        child:Icon(Icons.add),
      ),
    );
  }
}
