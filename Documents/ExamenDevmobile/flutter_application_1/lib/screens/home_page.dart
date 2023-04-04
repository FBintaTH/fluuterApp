// import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp();
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final String title;

//   MyHomePage({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Bienvenue sur mon application',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Commencer'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SecondPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SecondPage extends StatefulWidget {
//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   double _progress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _startProgress();
//   }

//   void _startProgress() async {
//     while (_progress < 1.0) {
//       await Future.delayed(Duration(milliseconds: 100));
//       setState(() {
//         _progress += 0.01;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Deuxième page'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Chargement en cours...',
//             style: TextStyle(fontSize: 24),
//           ),
//           SizedBox(height: 20),
//           LinearProgressIndicator(
//             value: _progress,
//             backgroundColor: Colors.grey,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           ),
//           SizedBox(height: 20),
//           Text(
//             '${(_progress * 100).toStringAsFixed(0)} %',
//             style: TextStyle(fontSize: 24),
//           ),
//         ],
//       ),
//     );
//   }
// }
