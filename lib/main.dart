import 'package:flutter/material.dart';
import 'package:wonderful_kalsel/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wonderful Kalsel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: Colors.white,
       visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}