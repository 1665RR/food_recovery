import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/api/api_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({Key? key}) : super(key: key);

  @override
  _AddCategoryWidgetState createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  File? _image;

  final _picker = ImagePicker();

  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _itemsController = TextEditingController();
  final _categoryController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              const Text('Name'),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Category Name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter category name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
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
                                  child: const Text('Select An Icon'),
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
                                    : const Text('Please select an icon'),
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
                                      var req = await ApiService().addCategory(
                                        sharedToken!,
                                        _nameController.text,
                                        _image!,
                                      );
                                      if (req.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Category added successfully!')));
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
