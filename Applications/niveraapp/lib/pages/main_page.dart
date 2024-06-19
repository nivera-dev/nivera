import 'package:flutter/material.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/pages/account_page.dart';
import 'package:niveraapp/pages/blog_page.dart';
import 'package:niveraapp/pages/home_screen.dart';
import 'package:niveraapp/pages/poducts_page.dart';
import 'package:niveraapp/pages/simulation_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePageTab(),
    const ProductsPage(),
    const SimulationPage(),
    const BlogPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: ColorPalette.greyFloor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigateBottomBar,
        currentIndex: _selectedIndex,
        iconSize: 25.0,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        backgroundColor: ColorPalette.whiteFloor,
        selectedItemColor: ColorPalette.mainColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_input_component_outlined),
              label: "Products"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_rounded, color: ColorPalette.subColor,),
              label: "Simulation",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Blog"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Account"
          ),
        ],
      ),
    );
  }
}
