import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonderful_kalsel/model/country_model.dart';

class Tambah extends StatefulWidget {
  final List<CountryModel> country;
  final Function() onUpdateCountryList;

  const Tambah(
      {Key? key, required this.country, required this.onUpdateCountryList})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final TextEditingController namaWisataController = TextEditingController();
  final TextEditingController namaKotaController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            _buildImageUpload(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addCountry();
                widget.onUpdateCountryList();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 38, 131, 95),
              ),
              child: Text(
                'Tambah Data',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 38, 131, 95)),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 38, 131, 95), width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 38, 131, 95), width: 1.0),
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
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: _image == null
                ? const Icon(
                    Icons.add_a_photo,
                    color: Color.fromARGB(255, 38, 131, 95),
                  )
                : Image.memory(
                    _image!.readAsBytesSync(),
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  void _addCountry() {
    try {
      if (_areFieldsValid()) {
        CountryModel newCountry = CountryModel(
          namaWisata: namaWisataController.text,
          namaKota: namaKotaController.text,
          label: labelController.text,
          deskripsi: deskripsiController.text,
          alamat: alamatController.text,
          rating: double.parse(ratingController.text),
          imgUrl: 'url_placeholder',
        );

        widget.country.add(newCountry);
        widget.onUpdateCountryList();

        _clearTextControllers();
        setState(() {
          _image = null;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Data berhasil ditambahkan.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding country: $e');
      }
    }
  }

  bool _areFieldsValid() {
    if (namaWisataController.text.isEmpty ||
        namaKotaController.text.isEmpty ||
        labelController.text.isEmpty ||
        deskripsiController.text.isEmpty ||
        alamatController.text.isEmpty ||
        ratingController.text.isEmpty ||
        _image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Semua field harus diisi dan gambar harus dipilih.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
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
