// splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wonderful_kalsel/main.dart';
// Sesuaikan dengan lokasi main.dart

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  Future<void> _loadSplash() async {
    // Menunggu beberapa detik sebelum berpindah ke halaman utama
    await Future.delayed(const Duration(seconds: 5));

    // Pindah ke halaman utama
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(country: [],),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset('assets/logo.png', height: 130, width: 130,
              ), // Sesuaikan dengan path logo Anda
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 38, 131, 95)),
            ), // Indikator loading
          ],
        ),
      ),
    );
  }
}
