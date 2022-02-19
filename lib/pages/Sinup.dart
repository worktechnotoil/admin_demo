// ignore_for_file: deprecated_member_use

import 'dart:js';

import 'package:ServiceApp/main.dart';
import 'package:ServiceApp/pages/login.dart';
import 'package:ServiceApp/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SinupScreen extends StatefulWidget {
  const SinupScreen({Key? key}) : super(key: key);

  @override
  _SinupScreenState createState() => _SinupScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
get user => _auth.currentUser;

void signUp(email, password, name) async {
  await _auth
      .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
      .then((value) => {
            postDetailedTofirestore(email, password, name, context),
          })
      .catchError((e) {
    Fluttertoast.showToast(msg: e!.message);
  });
}

postDetailedTofirestore(emai, pass, name, context) async {
  User? user = _auth.currentUser;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String id;
  firebaseFirestore.collection("SignUp").add({
    "UserEmail": emai,
    "UserName": pass,
    'name': name,
    // "uid": currentUser.uid,
  });
  Fluttertoast.showToast(msg: "accounts create suceesfully");
  // Navigator.pushAndRemoveUntil((context),MaterialPageRoute(builder: (context)) =>,Home) => false)
  Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false);
}

class _SinupScreenState extends State<SinupScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      // ignore: sized_box_for_whitespace
      child: Container(
        height: screenHeight,
        width: screenWidth,
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
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Text(
                    'Ragistration',
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
                // ignore: sized_box_for_whitespace
                Container(
                  width: isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 400,
                  child: TextField(
                    cursorColor: Colors.black,
                    textAlign:
                        isMobile(context) ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: isDesktop(context) ? 25 : 14,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: namecontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter name',
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 5, bottom: 11, top: 11, right: 5),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 400,
                  child: TextField(
                    cursorColor: Colors.black,
                    textAlign:
                        isMobile(context) ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: isDesktop(context) ? 25 : 14,
                    ),
                    controller: emailcontroller,
                    keyboardType: TextInputType.text,
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
                // ignore: sized_box_for_whitespace
                Container(
                  width: isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 400,
                  child: TextField(
                    cursorColor: Colors.black,
                    textAlign:
                        isMobile(context) ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: isDesktop(context) ? 25 : 14,
                    ),
                    keyboardType: TextInputType.text,
                    controller: passwordcontroller,
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
                    child: const Text("Ragister"),
                    onPressed: () {
                      signUp(emailcontroller.text, passwordcontroller.text,
                          namecontroller.text);
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: isMobile(context)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            (context),
                            MaterialPageRoute(
                                builder: (context) =>  Login_screen()),
                            (route) => false);
                      }
                      // Navigator.pushNamed(context, "YourRoute");
                      ,
                      child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "login screen",
                            style: TextStyle(color: Colors.green),
                          )),
                    ),
                    const Text(
                      " forget password",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
