import 'package:bitaqwa/presentation/screen/BitaqwaApp.dart';
import 'package:bitaqwa/presentation/screen/kajian_screen.dart';
import 'package:bitaqwa/presentation/screen/SholatPage.dart';
import 'package:bitaqwa/presentation/screen/ZakatPage.dart';
import 'package:bitaqwa/presentation/screen/doa_screen.dart';
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
      title: 'Bitaqwa',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/doa': (context) => const DoaScreen(),
        '/zakat': (context) => const ZakatScreen(),
        '/sholat': (context) => const JadwalSholatScreen(),
        '/kajian': (context) => const KajianScreen(),
      },
    );
  }
}
