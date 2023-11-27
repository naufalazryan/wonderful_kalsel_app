import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Details extends StatefulWidget {
  final String imgUrl;
  final String namaTempat;
  final double rating;
  final String label;
  final String namaKota;
  final String alamat;

  const Details({super.key, 
    required this.rating,
    required this.imgUrl,
    required this.namaTempat,
    required this.label,
    required this.namaKota,
    required this.alamat,
  });

  @override
  // ignore: library_private_types_in_public_api
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
          children: [
            Container(
              height: 240,
              child: ImageListTile(
                imgUrl: widget.imgUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: DetailsCard(
                namaTempat: widget.namaTempat,
                rating: widget.rating,
                deskripsi: widget.label,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: FeaturesTile(
                icon: Icon(Icons.place),
                label: widget.namaKota,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: FeaturesTile(
                icon: Icon(Icons.location_on),
                label: widget.alamat,
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

  ImageListTile({required this.imgUrl});

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

  DetailsCard({
    required this.namaTempat,
    required this.rating,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 38, 131, 95),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 38, 131, 95),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.star,
              color: Color.fromARGB(255, 38, 131, 95),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                namaTempat,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  RatingBar(rating),
                  SizedBox(width: 8),
                  Text(
                    deskripsi,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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
  final Icon icon;
  final String label;

  FeaturesTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 38, 131, 95).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffD5E6F2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: icon,
          ),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double rating;

  RatingBar(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rating >= 1 ? Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 2 ? Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 3 ? Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 4 ? Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
        SizedBox(width: 3),
        Icon(
          Icons.star,
          color: rating >= 5 ? Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        ),
      ],
    );
  }
}
