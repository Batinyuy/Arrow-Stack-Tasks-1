import 'package:flutter/material.dart';
import '/main_screen.dart';

void main() => runApp(const ShopWithUsApp());

class ShopWithUsApp extends StatelessWidget {
  const ShopWithUsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopWithUs',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)), scaffoldBackgroundColor: const Color(0xFFF8F7FB)),
      home: const MainScreen(),
    );
  }
}