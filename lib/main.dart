import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce UPSA',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const Placeholder(), // luego reemplazamos por LoginScreen()
      debugShowCheckedModeBanner: false,
    );
  }
}

