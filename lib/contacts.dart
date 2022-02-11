// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with TickerProviderStateMixin {
  bool _isLoading = true;

  List contactList = [];
  final firestoreInstance = FirebaseFirestore.instance;
  List contacts = [];

  fetchAllContact() {
    firestoreInstance.collection("Service").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        contactList.add(result.data());
      });
      setState(() {
        contacts.addAll(contactList);
        _isLoading = false;
      });
    });
  }

  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..addListener(() {
    //     setState(() {
    //       controller.repeat(reverse: true);
    //     });
    //   });

    fetchAllContact();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      // ignore: prefer_const_constructors
                      child: TextField(
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Search',
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: contacts.length, //or 'foods.length'
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.white,
                          elevation: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 25, 0),
                                    child: Text(
                                      contacts[index]['title'],
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                    contacts[index]['type'].toString(),
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.grey),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                      iconSize: 16,
                                      color: Colors.grey)
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Padding(
                                    // ignore: prefer_const_constructors
                                    padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                    child: Text(
                                      contacts[index]['units'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  // ignore: prefer_const_constructors
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                      iconSize: 16,
                                      color: Colors.red)
                                ],
                              )
                            ],
                          ),
                        );
                      }))
            ],
          );
  }
}
