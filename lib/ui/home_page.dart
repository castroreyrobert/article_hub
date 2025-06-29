import 'package:article_hub/ui/cart_page.dart';
import 'package:article_hub/ui/products/pages/discover_page.dart';
import 'package:article_hub/ui/products/pages/search_page.dart';
import 'package:article_hub/ui/saved_page.dart';
import 'package:flutter/material.dart';

import 'account_page.dart';

enum BottomNavMenu {
  discover("Discover"),
  search("Search"),
  saved("Recent"),
  cart("Cart"),
  account("Profile");

  const BottomNavMenu(this.title);
  final String title;

  String getTitle() => title;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _title = BottomNavMenu.values[0].getTitle();
  final PageController _pageController = PageController(initialPage: 0);



  static const List<Widget> _bottomNavigationScreens = <Widget>[
    DiscoverPage(),
    SearchPage(),
    SavedPage(),
    CartPage(),
    AccountPage()
  ];

  void _onBottomNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _title = BottomNavMenu.values[index].getTitle();
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _selectedIndex = _pageController.page!.round();
        _title = BottomNavMenu.values[_selectedIndex].getTitle();
      });

    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: _bottomNavigationScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Discover" ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search" ),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved" ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart" ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account" )
      ],
        currentIndex: _selectedIndex,
        onTap: _onBottomNavItemSelected,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

