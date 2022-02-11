// import 'package:flutter/material.dart';

// class EventsPage extends StatefulWidget {
//   const EventsPage({Key? key}) : super(key: key);

//   @override
//   _EventsPageState createState() => _EventsPageState();
// }

// class _EventsPageState extends State<EventsPage> {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: avoid_unnecessary_containers
//     return Container(
//       child: (
//           //_showDialog()

//           TextButton(
//         onPressed: () {
//           _showDialog(context);
//         },
//         child: const Text(
//           'YES',
//           style: TextStyle(color: Colors.black),
//         ),
//       )),
//     );
//   }

//   _showDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Expanded(
//           child: AlertDialog(
//             // title: const Text('Welcome'),
//             content: const Text('Do you want to logout?'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text(
//                   'YES',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text(
//                   'NO',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
