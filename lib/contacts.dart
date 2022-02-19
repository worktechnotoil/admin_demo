// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with TickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();

  bool _isLoading = true;
  var uuid = Uuid();

  List contactList = [];
  final firestoreInstance = FirebaseFirestore.instance;
  List contacts = [];

  fetchAllContact() {
    firestoreInstance.collection("Service").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        contactList.add(result.data());
      });

      print(contactList);

      setState(() {
        contacts.addAll(contactList);
        _isLoading = false;
      });
    });
  }

  void createRecord(title, type, units) async {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    firestoreInstance.collection("Service").add({
      "id": uuid.v4(),
      "title": title,
      "type": type,
      "units": units,
      // "uid": currentUser.uid,
    }).then((value) {
      print(value.id);

      setState(() {});
      //idd= value.id;
    });
  }

  // ignore: non_constant_identifier_names
  //  Delete(data) {
  //   firestoreInstance.collection("Service")
  //   .doc(data)
  //   .delete()
  //   .then((_) {
  //     print("success!");
  //   });
  //}
  CollectionReference users = FirebaseFirestore.instance.collection('Service');

  Future<void> deleteUser(data) {
    return users
        .doc(data)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  CollectionReference updater =
      FirebaseFirestore.instance.collection('Service');

  Future<void> updateUser(title, type, units) {
    return updater
        .doc('F8wK3cv3cJfZX6G5nP8G')
        .update({
          'title': title,
          'type': type,
          'units': units,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    fetchAllContact();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String data;
    final _formKey = GlobalKey<FormState>();
    return _isLoading == true
        ? const Center(child: CircularProgressIndicator())
        : StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Service').snapshots(),
            builder: (context, snapshot) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Stack(
                                        overflow: Overflow.visible,
                                        children: <Widget>[
                                          Positioned(
                                            right: -40.0,
                                            top: -40.0,
                                            child: InkResponse(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const CircleAvatar(
                                                child: Icon(Icons.close),
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    onFieldSubmitted: (value) {
                                                      //Validator
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Enter type units!';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        _titleController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Enter your title',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: _typeController,
                                                    onFieldSubmitted:
                                                        (value) {},
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Enter type service!';
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Enter your type',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Enter type units!';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        _unitsController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Enter your units',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: RaisedButton(
                                                    // ignore: prefer_const_constructors
                                                    child: Text("Submitß"),
                                                    onPressed: () {
                                                      final isValid = _formKey
                                                          .currentState!
                                                          .validate();
                                                      if (!isValid) {
                                                        return;
                                                      }
                                                      _formKey.currentState!
                                                          .save();
                                                      createRecord(
                                                        _titleController.text,
                                                        _typeController.text,
                                                        _unitsController.text,
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 0, 0),
                                            child: Text(
                                              contacts[index]['title']
                                                  .toString(),
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 0, 0),
                                            child: Text(
                                              contacts[index]['type']
                                                  .toString(),
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 0, 0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    _titleController.text =
                                                        contacts[index]
                                                            ['title'];

                                                    _typeController.text =
                                                        contacts[index]['type'];

                                                    _unitsController.text =
                                                        contacts[index]
                                                            ['units'];

                                                    setState(() {});

                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Stack(
                                                              overflow: Overflow
                                                                  .visible,
                                                              children: <
                                                                  Widget>[
                                                                Positioned(
                                                                  right: -40.0,
                                                                  top: -40.0,
                                                                  child:
                                                                      InkResponse(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const CircleAvatar(
                                                                      child: Icon(
                                                                          Icons
                                                                              .close),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Form(
                                                                  key: _formKey,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            TextFormField(
                                                                          onFieldSubmitted:
                                                                              (value) {
                                                                            //Validator
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return 'Enter type units!';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          controller:
                                                                              _titleController,
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            labelText:
                                                                                'Enter your title',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _typeController,
                                                                          onFieldSubmitted:
                                                                              (value) {},
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return 'Enter type service!';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            labelText:
                                                                                'Enter your type',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            TextFormField(
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return 'Enter type units!';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          controller:
                                                                              _unitsController,
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            labelText:
                                                                                'Enter your units',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            RaisedButton(
                                                                          // ignore: prefer_const_constructors
                                                                          child:
                                                                              Text("Submitß"),
                                                                          onPressed:
                                                                              () {
                                                                            final isValid =
                                                                                _formKey.currentState!.validate();
                                                                            if (!isValid) {
                                                                              return;
                                                                            }
                                                                            _formKey.currentState!.save();
                                                                            updateUser(
                                                                              _titleController.text,
                                                                              _typeController.text,
                                                                              _unitsController.text,
                                                                            );
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  iconSize: 16,
                                                  color: Colors.grey))
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            // ignore: prefer_const_constructors
                                            padding: EdgeInsets.fromLTRB(
                                                0, 5, 10, 0),
                                            child: Text(
                                              contacts[index]['units']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          // ignore: prefer_const_constructors
                                          Padding(
                                              // ignore: prefer_const_constructors
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: IconButton(
                                                  onPressed: () async {
                                                    var collection =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Service');
                                                    // <-- Document ID

                                                    // String documentID =
                                                    //     FirebaseFirestore.doc()
                                                    //         .documentID;

                                                    deleteUser(
                                                        "F8wK3cv3cJfZX6G5nP8G");
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  iconSize: 16,
                                                  color: Colors.red))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }))
                    ],
                  ));
            });
  }
}
