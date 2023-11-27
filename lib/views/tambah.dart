import 'package:flutter/material.dart';

class Tambah extends StatelessWidget {
  const Tambah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
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
