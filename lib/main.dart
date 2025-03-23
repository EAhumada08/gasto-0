import 'package:flutter/material.dart';
import 'package:gasto_0/main_theme.dart';
import 'features/auth/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: Login(),
    );
  }
}
