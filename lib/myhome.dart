import 'package:flutter/material.dart';
import 'package:master_resonsive_demo/side.dart';

class Myhome extends StatefulWidget {
  const Myhome({ Key? key }) : super(key: key);

  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      drawer: const SideMenu(),
     appBar: AppBar(
          title: const Text("Flutte dashboard"),
        ),
        body: const Center(
            child: Center(child: Text("This is Home page"))
        ),
        
      
    );
  }


}