// ignore_for_file: deprecated_member_use



import 'package:ServiceApp/main.dart';
import 'package:ServiceApp/pages/Sinup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../responsive.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login_screen extends StatefulWidget {
  Login_screen({Key? key}) : super(key: key);

  @override
  _Login_screenState createState() => _Login_screenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
get user => _auth.currentUser;
Future Singin(String email, String password, context) async {
  try {
    await _auth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((uid) => {
              Fluttertoast.showToast(msg: "login suceesful"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage())),
            });
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
}

// ignore: camel_case_types
class _Login_screenState extends State<Login_screen> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: screenHeight,
      width: screenWidth,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: !isMobile(context)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.center,
              crossAxisAlignment: !isMobile(context)
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Container(
                  child: Text(
                    'Login page',
                    textAlign:
                        isMobile(context) ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                        fontSize: isDesktop(context) ? 36 : 18,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 400,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    textAlign:
                        isMobile(context) ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: isDesktop(context) ? 25 : 14,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,
                    onSaved: (value) {
                      emailcontroller.text = value!;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 5, bottom: 11, top: 11, right: 5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 400,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    textAlign:
                        isMobile(context) ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: isDesktop(context) ? 25 : 14,
                    ),
                    controller: passwordcontroller,
                    onSaved: (value) {
                      passwordcontroller.text = value!;
                    },
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password! is require for login';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter password',
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 5, bottom: 11, top: 11, right: 5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: const Text("login"),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var email =
                          prefs.setString('email', emailcontroller.text);
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      _formKey.currentState!.save();
                      Singin(emailcontroller.text, passwordcontroller.text,
                          context);
                      //  Navigator.of(context).pop();
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SinupScreen()),
                    );
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        " you don't have account ragister",
                        style: TextStyle(color: Colors.green),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
