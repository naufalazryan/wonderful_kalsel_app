import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonderful_kalsel/data/data.dart';
import 'package:wonderful_kalsel/model/country_model.dart';
import 'package:wonderful_kalsel/model/popular_tours_model.dart';
import 'package:wonderful_kalsel/views/details.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PopularTourModel> popularTourModels = [];
  List<CountryModel> country = [];
  List<CountryModel> filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    country = getCountries();
    popularTourModels = getPopularTours();
    filteredCountries = List.from(country);
    super.initState();
  }

  void filterCountries(String query) {
    setState(() {
      filteredCountries = country
          .where((country) =>
              country.namaWisata.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(0, 0), child: Container()),
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
                "Kota",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Color.fromARGB(255, 38, 131, 95),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 40,
                    width: 450,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromARGB(255, 38, 131, 95),
                      ),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          controller: searchController,
                          onChanged: filterCountries,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.transparent,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          left: 10,
                          top: searchController.text.isNotEmpty ? -16 : 9,
                          child: Text(
                            'Cari...',
                            style: GoogleFonts.montserrat(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),
              // Country List
              Container(
                height: 240,
                child: ListView.builder(
                  itemCount: filteredCountries.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CountryListTile(
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
                              namaTempat: filteredCountries[index].namaWisata,
                              rating: filteredCountries[index].rating,
                              label: filteredCountries[index].label,
                              namaKota: filteredCountries[index].namaWisata,
                              alamat: filteredCountries[index].alamat,
                              // Add any other parameters needed for country details
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 8),
              Text(
                "Populer",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Color.fromARGB(255, 38, 131, 95),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              // Popular Tours
              Container(
                height: 240,
                child: ListView.builder(
                  itemCount: popularTourModels.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PopularTours(
                      desc: popularTourModels[index].desc,
                      imgUrl: popularTourModels[index].imgUrl,
                      title: popularTourModels[index].title,
                      price: popularTourModels[index].price,
                      rating: popularTourModels[index].rating,
                    );
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
  final String title;
  final String desc;
  final String price;
  final double rating;

  PopularTours({
    required this.imgUrl,
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
              namaTempat: title,
              rating: rating,
              label: title, // Assuming you want to use the title as the label
              namaKota: '', // Add a value for namaKota
              alamat: '', // Add a value for alamat
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Color(0xffE9F4F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
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
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                  SizedBox(height: 6),
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
            Spacer(),
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

  CountryListTile({
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 220,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 200,
              width: 150,
              child: Column(
                children: [
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
                  Spacer(),
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
                            Container(
                              child: Text(
                                namaWisata,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
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
                      Spacer(),
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
