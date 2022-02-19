import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  String? finaeMial;

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('email');
    setState(() {
      finaeMial = email!;
    });
  }
  // ignore: prefer_typing_uninitialized_variables
  // var loggeduser;
  // User? user = FirebaseAuth.instance.currentUser;
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("SignUp")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) =>
  //           // ignore: unnecessary_this
  //           {this.loggeduser = (value.data())});
  //   setState(() {});
  // }

  @override
  void initState() {
    getvalidationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('assets/profile.jpg'),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          Text(
            "devi",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            // ignore: unnecessary_string_interpolations
            "$finaeMial",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
