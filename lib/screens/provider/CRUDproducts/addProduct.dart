import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/api/api_services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductWidget extends StatefulWidget {
  @override
  _AddProductWidgetState createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  List categoryItemlist = [];
  Future getAllCategory() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    categoryItemlist = (await ApiService().fetchCategories(sharedToken!));

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  File? _image;

  final _picker = ImagePicker();

  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _itemsController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  late var multipartFile;

  late final File selectedImage;
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        (await _picker.pickImage(source: ImageSource.gallery));
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  @override
  void initState() {
    _dateInputController.text = ""; //set the initial value of text field
    super.initState();
    getAllCategory();
  }

  var dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Name'),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: ' Name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              const Text('Description'),
                              TextFormField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  hintText: ' Description',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter description';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller:
                                    _dateInputController, //editing controller of this TextField
                                decoration: const InputDecoration(
                                    icon: Icon(Icons
                                        .calendar_today), //icon of text field
                                    labelText:
                                        "Enter Date" //label text of field
                                    ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      _dateInputController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Number of items left'),
                              TextFormField(
                                controller: _itemsController,
                                decoration: const InputDecoration(
                                  hintText: 'Number of items left',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter number of items left';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                hint: const Text('Select Category'),
                                items: categoryItemlist.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item.name),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select category';
                                  }
                                  return null;
                                },
                                onChanged: (newVal) {
                                  setState(() {
                                    dropdownvalue = newVal;
                                  });
                                },
                                value: dropdownvalue,
                              ),
                            ],
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(35),
                            child: Column(children: [
                              Center(
                                child: ElevatedButton(
                                  child: const Text('Select An Image'),
                                  onPressed: _openImagePicker,
                                ),
                              ),
                              const SizedBox(height: 35),
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 300,
                                color: Colors.grey[300],
                                child: _image != null
                                    ? Image.file(_image!, fit: BoxFit.cover)
                                    : const Text('Please select an image'),
                              )
                            ]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  var sharedToken =
                                      sharedPreferences.getString('token');
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    try {
                                      var req = await ApiService().addProducts(
                                        sharedToken!,
                                        _nameController.text,
                                        _descriptionController.text,
                                        _dateInputController.text,
                                        int.parse(_itemsController.text),
                                        dropdownvalue,
                                        _image!,
                                      );
                                      if (req.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Product added successfully!')));
                                        print(req.body);
                                        Navigator.pop(context);
                                      } else {
                                        print(req.body);
                                      }
                                    } on Exception catch (e) {
                                      print(e.toString());
                                      print('catched error');
                                    }
                                  }
                                },
                                child: const Text('Save',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
