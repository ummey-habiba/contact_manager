import 'package:contact_manager/models/contact_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'as path;

class DbHelper{
  final createTableContact = '''create table $tableContact(
  $tblContactColId integer primary key ,
  $tblContactColName text,
  $tblContactColMobile text,
  $tblContactColEmail text,
  $tblContactColGender text,
  $tblContactColGroup text,
  $tblContactColDob text,
  $tblContactColImage text,
  $tblContactColAddress text,
  $tblContactColFavourite integer,
  $tblContactColWebsite text)''';
  Future<Database> _open()async{
    final rootPath = await getDatabasesPath();
    final dbPath= path.join(rootPath, 'contact.db');
    return  openDatabase(dbPath,version: 1,onCreate: (db, version) {
      db.execute(createTableContact);
    },);

  }
Future<int> insertContact(ContactModel contact) async{
    final db = await _open();
    return db.insert(tableContact,contact.toMap());
}
}