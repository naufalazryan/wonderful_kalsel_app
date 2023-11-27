import 'package:flutter/material.dart';

class Pencarian extends StatelessWidget {
  const Pencarian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Halaman Pencarian'),
          ],
        ),
      ),
    );
  }
}
