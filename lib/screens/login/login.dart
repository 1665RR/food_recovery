import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/header_widget.dart';
import '../home/home_screen.dart';
import '../registration/registration.dart';
// import 'package:flutter_login_ui/common/theme_helper.dart';
//
// import 'forgot_password_page.dart';
// import 'profile_page.dart';
// import 'registration_page.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Sign in into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const TextField(
                                decoration: InputDecoration(labelText: 'User Name', hintText: 'Enter your user name'),
                              ),
                              const SizedBox(height: 30.0),
                              const TextField(
                                obscureText: true,
                                decoration: InputDecoration(labelText: 'Password', hintText: 'Enter your password'),
                              ),
                              const SizedBox(height: 15.0),
                              ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  //redirect
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          const TextSpan(text: "Don't have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                               Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }
}