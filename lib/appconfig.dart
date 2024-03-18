import 'package:flutter/material.dart';
import 'package:salt/screens/login.dart';

class SaltApp extends StatelessWidget {
  const SaltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Salt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    routes: {
      '/': (context) => const LoginScreen()
    },
  );;
  }
}