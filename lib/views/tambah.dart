// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wonderful_kalsel/model/country_model.dart';

class Tambah extends StatefulWidget {
  const Tambah({Key? key}) : super(key: key);

  @override
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final TextEditingController namaWisataController = TextEditingController();
  final TextEditingController namaKotaController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  List<CountryModel> countries = [];
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data'),
        backgroundColor: const Color.fromARGB(255, 38, 131, 95),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Nama Wisata', namaWisataController),
            const SizedBox(height: 10),
            _buildTextField('Nama Kota', namaKotaController),
            const SizedBox(height: 10),
            _buildTextField('Label', labelController),
            const SizedBox(height: 10),
            _buildTextField('Deskripsi', deskripsiController),
            const SizedBox(height: 10),
            _buildTextField('Alamat', alamatController),
            const SizedBox(height: 10),
            _buildTextField(
              'Rating',
              ratingController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            _buildImageUpload(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCountry,
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 38, 131, 95),
              ),
              child: const Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 38, 131, 95)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 38, 131, 95), width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 38, 131, 95), width: 1.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Image',
          style: TextStyle(color: Color.fromARGB(255, 38, 131, 95)),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 38, 131, 95), width: 2.0),
            ),
            child: _image == null
                ? Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 38, 131, 95),
                    size: 50,
                  )
                : Image.file(_image!),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addCountry() {
    CountryModel newCountry = CountryModel(
      namaWisata: namaWisataController.text,
      namaKota: namaKotaController.text,
      label: labelController.text,
      deskripsi: deskripsiController.text,
      alamat: alamatController.text,
      rating: double.tryParse(ratingController.text) ?? 0.0,
      imgUrl: _image?.path ?? '',
    );

    setState(() {
      countries.add(newCountry);
    });

    _clearTextControllers();
    setState(() {
      _image = null;
    });

    Navigator.pop(context);
  }

  void _clearTextControllers() {
    namaWisataController.clear();
    namaKotaController.clear();
    labelController.clear();
    deskripsiController.clear();
    alamatController.clear();
    ratingController.clear();
  }
}
