import 'package:article_hub/ui/cart_page.dart';
import 'package:article_hub/ui/products/pages/discover_page.dart';
import 'package:article_hub/ui/products/pages/search_page.dart';
import 'package:article_hub/ui/saved_page.dart';
import 'package:flutter/material.dart';

import 'account_page.dart';

enum BottomNavMenu {
  discover("Discover"),
  search("Search"),
  saved("Favorites"),
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
        actions:[
          if (_selectedIndex == 4)
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        ]
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: _bottomNavigationScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined), label: "Discover" ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search" ),
          BottomNavigationBarItem(icon: Icon(_selectedIndex == 2 ? Icons.favorite : Icons.favorite_border), label: "Favorites" ),
          BottomNavigationBarItem(icon: Icon(_selectedIndex == 3 ? Icons.shopping_cart : Icons.shopping_cart_outlined), label: "Cart" ),
          BottomNavigationBarItem(icon: Icon(_selectedIndex == 4 ? Icons.person : Icons.person_outline), label: "Account" )
        ],
        currentIndex: _selectedIndex,
        onTap: _onBottomNavItemSelected,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

