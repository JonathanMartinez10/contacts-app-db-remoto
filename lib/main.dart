import 'package:contacts_app/screens/contacts_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Contactos',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const ContactsScreen(),
    );
  }
}
