import 'package:flutter/material.dart';
import 'package:hungry/fetures/auth/views/login_veiw.dart';
import 'package:hungry/fetures/auth/views/signup_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hungry?",
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Root(),
    );
  }
}
