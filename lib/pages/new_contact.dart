import 'dart:io';
import 'package:contact_manager/models/contact_models.dart';
import 'package:contact_manager/provider/contact_provider.dart';
import 'package:contact_manager/utils/constants.dart';
import 'package:contact_manager/utils/helper_funtion.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  static const String routeName = '/new';

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _webController = TextEditingController();
  DateTime? _selectedDate;
  String? _group;
  String? _imagePath;
  final _formKey = GlobalKey<FormState>();
  Gender gender = Gender.Male;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          children: [
            Column(
              children: [
                Card(
                  elevation: 5.0,
                  child: _imagePath == null
                      ? const Icon(
                    Icons.person,
                    size: 100,
                  )
                      : Image.file(
                    File(_imagePath!),
                    height: 100,
                    width: 100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        _getImage(ImageSource.camera);
                      },
                      label: const Text('Capture'),
                      icon: const Icon(Icons.camera),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        _getImage(ImageSource.gallery);
                      },
                      label: const Text('Gallery'),
                      icon: const Icon(Icons.photo),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _nameController,
                decoration:   const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Name(required)',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a contact name ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number(required)',
                  prefixIcon: Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a contact number ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address(required)',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a Email address ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Street Address(required)',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a Street address ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _webController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'WebSite(optoional)',
                  prefixIcon: Icon(Icons.web),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: _selectDob,
                        child: const Text('Select a date')),
                    Text(_selectedDate == null
                        ? 'No date chosen'
                        : getFormattedDate(_selectedDate!)!)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  hint: const Text('Select group'),
                  value: _group,
                  isExpanded: true,
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: groups
                      .map((group) =>
                      DropdownMenuItem(value: group, child: Text(group)))
                      .toList(),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a group';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Select Gender'),
            ),
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.Male,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text(Gender.Male.name),
                Radio<Gender>(
                  value: Gender.Female,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text(Gender.Female.name),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel.name(

        name: _nameController.text,
        email: _emailController.text,
        address: _addressController.text,
        mobile: _mobileController.text,
        website: _webController.text,
        group: _group??'No group found',
        gender: gender.name,
        image: _imagePath,
        dob: getFormattedDate(_selectedDate)

      );
      print(contact);
    context.read<ContactProvider>().addContact(contact).then((value) {
        showMsg(context, 'Saved');
        Navigator.pop(context);
      },).catchError((error){
        
        showMsg(context, error.toString());
      });


    }
  }

  void _selectDob() async {
    final date = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      setState(() {
        _imagePath = xFile.path;
      });
    }
  }
}
