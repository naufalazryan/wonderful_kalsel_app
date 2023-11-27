// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  final String imgUrl;
  final String namaWisata;
  final String deskripsi;
  final double rating;
  final String label;
  final String namaKota;
  final String alamat;

  const Details({
    Key? key,
    required this.rating,
    required this.imgUrl,
    required this.namaWisata,
    required this.deskripsi,
    required this.label,
    required this.namaKota,
    required this.alamat,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 240,
              child: ImageListTile(
                imgUrl: widget.imgUrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DetailsCard(
                namaTempat: widget.namaWisata,
                rating: widget.rating,
                deskripsi: widget.label,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FeaturesTile(
                icon: const Icon(Icons.location_on),
                label: widget.alamat,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FeaturesTile(
                label: widget.deskripsi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageListTile extends StatelessWidget {
  final String imgUrl;

  const ImageListTile({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  final String namaTempat;
  final double rating;
  final String deskripsi;

  const DetailsCard({super.key, 
    required this.namaTempat,
    required this.rating,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const  Color.fromARGB(255, 38, 131, 95),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 38, 131, 95),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.star,
              color: Color.fromARGB(255, 38, 131, 95),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namaTempat,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  RatingBar(rating),
                  const SizedBox(width: 8),
                  Text(
                    deskripsi,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeaturesTile extends StatelessWidget {
  final Icon? icon;
  final String label;

  const FeaturesTile({Key? key, this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 38, 131, 95).withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffD5E6F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: icon!,
            ),
          SizedBox(width: icon != null ? 12 : 0),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double rating;

  const RatingBar(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rating >= 1 ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        const SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 2 ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        const SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 3 ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        const SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 4 ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        const SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 5 ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
      ],
    );
  }
}
