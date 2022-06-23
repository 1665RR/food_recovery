import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth.dart';
import '../../models/user_model.dart';
import '../../widgets/header_widget.dart';
import '../home/home_screen.dart';
import '../registration/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthAPI _authAPI = AuthAPI();
  final double _headerHeight = 250;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
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
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email'),
                                onChanged: (val) => setState(() => email = val),
                              ),
                              const SizedBox(height: 30.0),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password'),
                                onChanged: (val) =>
                                    setState(() => password = val),
                              ),
                              const SizedBox(height: 15.0),
                              ElevatedButton(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'Sign In'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      var req =
                                          await _authAPI.login(email, password);
                                      if (req.statusCode == 200) {
                                        var user = User.fromReqBody(req.body);
                                        sharedPreferences.setString(
                                            'token', user.token);
                                        user.printAttributes();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      } else {
                                        print(req.body);
                                      }
                                    } on Exception catch (e) {
                                      print(e.toString());
                                      print('catched error');
                                    }
                                    //redirect
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const HomeScreen())
                                    // ); //popravi
                                  }
                                },
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  const TextSpan(
                                      text: "Don't have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void pushError(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Text('something went wrong')));
  }
}
