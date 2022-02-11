import 'package:ServiceApp/contacts.dart';
import 'package:ServiceApp/dashboard.dart';
import 'package:ServiceApp/my_drawer_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ServiceAdd",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.service) {
      container =  ContactsPage();
    } else if (currentPage == DrawerSections.Logout) {
      Future.delayed(Duration.zero, () => _showDialog(context));
      // } else if (currentPage == DrawerSections.notes) {
      //   container = NotesPage();
      // } else if (currentPage == DrawerSections.settings) {
      //   container = SettingsPage();
      // } else if (currentPage == DrawerSections.notifications) {
      //   container = NotificationsPage();
      // } else if (currentPage == DrawerSections.privacy_policy) {
      //   container = PrivacyPolicyPage();
      // } else if (currentPage == DrawerSections.send_feedback) {
      //   container = SendFeedbackPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text("Service App"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              children: [
                const MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "service", Icons.medical_services,
              currentPage == DrawerSections.service ? true : false),
          menuItem(3, "Logout", Icons.logout_outlined,
              currentPage == DrawerSections.Logout ? true : false),
          // menuItem(4, "Notes", Icons.notes,
          //     currentPage == DrawerSections.notes ? true : false),
          // const Divider(),
          // menuItem(5, "Settings", Icons.settings_outlined,
          //     currentPage == DrawerSections.settings ? true : false),
          // menuItem(6, "Notifications", Icons.notifications_outlined,
          //     currentPage == DrawerSections.notifications ? true : false),
          // Divider(),
          // menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
          //     currentPage == DrawerSections.privacy_policy ? true : false),
          // menuItem(8, "Send feedback", Icons.feedback_outlined,
          //     currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.service;
            } else if (id == 3) {
              currentPage = DrawerSections.Logout;
            }
            // else if (id == 4) {
            //   currentPage = DrawerSections.notes;
            // } else if (id == 5) {
            //   currentPage = DrawerSections.settings;
            // } else if (id == 6) {
            //   currentPage = DrawerSections.notifications;
            // } else if (id == 7) {
            //   currentPage = DrawerSections.privacy_policy;
            // } else if (id == 8) {
            //   currentPage = DrawerSections.send_feedback;
            //}
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            // title: const Text('Welcome'),
            content: const Text('Do you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'YES',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'NO',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum DrawerSections {
  dashboard,
  service,
  Logout,
  // notes,
  // settings,
  // notifications,
  // privacy_policy,
  // send_feedback,
}
 // ignore: unused_element
 


