import 'package:flutter/material.dart';
import 'package:food_app/api/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/header_widget.dart';
import '../login/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthAPI _authAPI = AuthAPI();

  late String name;
  late String email;
  late String phone;
  late String address;
  late String password;
  late String passwordConfirmation;
  late String description = '';
  late String photo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 35, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter your username'),
                          onChanged: (val) => setState(() => name = val),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email address'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (!(val!.isEmpty) &&
                                !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(val)) {
                              return "Enter a valid email address";
                            }
                          },
                          onChanged: (val) => setState(() => email = val),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password*',
                              hintText: 'Enter your password'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          onChanged: (val) => setState(() => password = val),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password confirmation*',
                              hintText: 'Confirm your password'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          onChanged: (val) =>
                              setState(() => passwordConfirmation = val),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Phone', hintText: 'Enter your phone'),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => setState(() => phone = val),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Address',
                              hintText: 'Enter your address'),
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (val) => setState(() => address = val),
                        ),
                        const SizedBox(height: 15.0),
                        ElevatedButton(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              "Register".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                var req = await _authAPI.signUp(
                                    name,
                                    email,
                                    phone,
                                    address,
                                    password,
                                    passwordConfirmation,
                                    description,
                                    photo);
                                if (req.statusCode == 200) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Successful registration!')));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                } else {
                                  print(req.body);
                                }
                              } on Exception catch (e) {
                                print(e.toString());
                                print('catched error');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
