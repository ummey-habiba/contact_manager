import 'package:contact_manager/database/db_helper.dart';
import 'package:contact_manager/models/contact_models.dart';
import 'package:flutter/foundation.dart';

class ContactProvider with ChangeNotifier{
List<ContactModels >_contactList= [];
List<ContactModels> get contactList => _contactList;
final _db = DbHelper();
Future<int> addContact(ContactModels contact) {
  return _db.insertContact(contact);
}
}