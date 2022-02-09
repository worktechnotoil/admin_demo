import 'package:flutter/material.dart';
import 'package:master_resonsive_demo/side.dart';

class Profile_page extends StatelessWidget {
 static const String routeName = '/eventPage';

 @override
 Widget build(BuildContext context) {
   return  Scaffold(
       appBar: AppBar(
         title: const Text("profile_page"),
       ),
       drawer: const SideMenu(),
       body: const Center(child: Text("Hey! this profile  page")));
 }
}