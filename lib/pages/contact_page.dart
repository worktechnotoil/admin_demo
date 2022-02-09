import 'package:flutter/material.dart';
import 'package:master_resonsive_demo/side.dart';

class contactPage extends StatelessWidget {
 static const String routeName = '/contactPage';

 @override
 Widget build(BuildContext context) {
   return  Scaffold(
       appBar: AppBar(
         title: const Text("Contacts_page"),
       ),
       drawer: const SideMenu(),
       body: const Center(child: Text("This is contacts page")));
 }
}