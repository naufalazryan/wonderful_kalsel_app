import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonderful_kalsel/data/data.dart';
import 'package:wonderful_kalsel/model/country_model.dart';
import 'package:wonderful_kalsel/model/popular_tours_model.dart';
import 'package:wonderful_kalsel/views/details.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final List<CountryModel> country;

  const Home({Key? key, required this.country}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PopularTourModel> popularTourModels = [];
  List<CountryModel> countries = [];
  List<CountryModel> filteredCountries = [];

  late ScrollController _scrollController;
  late Timer _timer;
  double _scrollPosition = 0.0;

  late PageController _cityPageController;

  @override
  void initState() {
    countries = getCountries();
    _scrollController = ScrollController();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
        _scrollPosition = 0.0;
      } else {
        _scrollPosition += MediaQuery.of(context).size.width;
      }

      _scrollController.animateTo(
        _scrollPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });


    popularTourModels = countries.map((countryy) {
      return PopularTourModel(
        title: countryy.namaWisata,
        label: countryy.label,
        desc: countryy.deskripsi,
        price: "",
        rating: countryy.rating,
        imgUrl: countryy.imgUrl,
      );
    }).toList();

    _cityPageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );

    _cityPageController.addListener(() {
      if (_cityPageController.position.atEdge) {
        if (_cityPageController.position.pixels == 0) {
          // Kembali ke akhir jika berada di awal
          _cityPageController
              .jumpTo(_cityPageController.position.maxScrollExtent);
        } else {
          // Pindah ke awal jika berada di akhir
          _cityPageController
              .jumpTo(_cityPageController.position.minScrollExtent);
        }
      }
    });

    filteredCountries = List.from(countries);
    super.initState();
  }

  @override
  void dispose() {
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
    _cityPageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(preferredSize: const Size(0, 0), child: Container()),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Menelusuri",
                style: GoogleFonts.montserrat(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Wisata",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 38, 131, 95),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Country List
              SizedBox(
                height: 240,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    children: List.generate(
                      filteredCountries.length,
                      (index) => CountryListTile(
                        label: filteredCountries[index].label,
                        namaWisata: filteredCountries[index].namaWisata,
                        namaKota: filteredCountries[index].namaKota,
                        alamat: filteredCountries[index].alamat,
                        rating: filteredCountries[index].rating,
                        imgUrl: filteredCountries[index].imgUrl,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                imgUrl: filteredCountries[index].imgUrl,
                                namaWisata: filteredCountries[index].namaWisata,
                                deskripsi: filteredCountries[index].deskripsi,
                                rating: filteredCountries[index].rating,
                                label: filteredCountries[index].label,
                                namaKota: filteredCountries[index].namaWisata,
                                alamat: filteredCountries[index].alamat,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Text(
                "Populer",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 38, 131, 95),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Popular Tours
              SizedBox(
                height: 240,
                child: ListView.builder(
                  itemCount: popularTourModels.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tour = popularTourModels[index];
                    if (tour.label.toLowerCase() == "populer") {
                      return PopularTours(
                        desc: tour.desc,
                        imgUrl: tour.imgUrl,
                        title: tour.title,
                        price: tour.price,
                        rating: tour.rating,
                        label: tour.label,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularTours extends StatelessWidget {
  final String imgUrl;
  final String label;
  final String title;
  final String desc;
  final String price;
  final double rating;

  const PopularTours({
    super.key,
    required this.imgUrl,
    required this.label,
    required this.rating,
    required this.desc,
    required this.price,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              imgUrl: imgUrl,
              namaWisata: title,
              rating: rating,
              label: title,
              deskripsi: title,
              namaKota: '',
              alamat: '',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xffE9F4F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             if (imgUrl.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: 110,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4E6059),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4E6059),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 8, right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xff139157),
              ),
              child: Column(
                children: [
                  Text(
                    "$rating",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryListTile extends StatelessWidget {
  final String namaKota;
  final String namaWisata;
  final String label;
  final String alamat;
  final double rating;
  final String imgUrl;
  final VoidCallback onTap;

  const CountryListTile({
    super.key,
    required this.label,
    required this.namaKota,
    required this.namaWisata,
    required this.alamat,
    required this.rating,
    required this.imgUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          children: [
              if (imgUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 220,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 200,
              width: 150,
              child: Column(
                children: [
                  if (imgUrl.isEmpty)
                        Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white30,
                          ),
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 184, 184, 184),
                            ),
                          ),
                        ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 8, top: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white30,
                        ),
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                          left: 8,
                          right: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              namaWisata,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              namaKota,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white38,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$rating",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
