import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonderful_kalsel/views/home.dart';
import 'package:wonderful_kalsel/views/pencarian.dart';
import 'package:wonderful_kalsel/views/splash_screen.dart';
import 'package:wonderful_kalsel/views/tambah.dart';
import 'package:wonderful_kalsel/model/country_model.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wonderful_kalsel/data/data.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<CountryModel> country = getCountries();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wonderful Kalsel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final List<CountryModel> country;

  const MainScreen({Key? key, required this.country}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/logo.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
          // Tambahkan teks di sebelah kanan logo
          Text(
            'Wonderful Kalsel',
            style: GoogleFonts.bonaNova(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // Tambahkan widget lain di sebelah kanan jika diperlukan
        ],
      ),
    );
  }

  Widget _buildBody() {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          fillColor: Colors.transparent,
          child: child,
        );
      },
      child: _selectedIndex == 0
          ? Home(country: widget.country)
          : (_selectedIndex == 1 ? const Pencarian() : _buildTambahScreen()),
    );
  }

  Widget _buildTambahScreen() {
    // Gantilah dengan widget yang seharusnya ditampilkan pada index 2
    return Tambah(
      country: widget.country,
      onUpdateCountryList: () {
        setState(() {
          // Tambahkan logika pembaruan layar tambahan di sini jika diperlukan
        });
      },
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: const Color.fromARGB(255, 38, 131, 95),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
        child: GNav(
          backgroundColor: const Color.fromARGB(255, 38, 131, 95),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 68, 205, 152),
          gap: 10,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Beranda',
            ),
            GButton(
              icon: Icons.search,
              text: 'Pencarian',
            ),
            GButton(
              icon: Icons.add,
              text: 'Tambah Data',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
