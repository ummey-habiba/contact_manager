import 'package:contact_manager/database/db_helper.dart';
import 'package:contact_manager/models/contact_models.dart';
import 'package:flutter/foundation.dart';

class ContactProvider with ChangeNotifier{
List<ContactModel >_contactList= [];
List<ContactModel> get contactList => _contactList;
final _db = DbHelper();
Future<int> addContact(ContactModel contact) {
  return _db.insertContact(contact);
}
}