import 'package:flutter/material.dart';
import 'package:wonderful_kalsel/views/home.dart';
import 'package:wonderful_kalsel/views/pencarian.dart';
import 'package:wonderful_kalsel/views/tambah.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/pencarian': (context) => const Pencarian(),
        '/tambah': (context) => const Tambah(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(), // Disable swipe navigation
      children: const [
        Home(),
        Pencarian(),
        Tambah(),
      ],
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: const Color.fromARGB(255, 38, 131, 95),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
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
              text: 'Pencaharian',
            ),
            GButton(
              icon: Icons.add,
              text: 'Tambah Data',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}

