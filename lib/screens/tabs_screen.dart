import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/categories_screen.dart';
import 'package:flutter_complete_guide/screens/favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  static const routeName = '/tabs-screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Map<String, Widget>> _pages = [
    {'page': const CategoriesScreen(), 'title': const Text('Categories')},
    {'page': const FavouritesScreen(), 'title': const Text('Your Favourite')}
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: _pages[_selectedPageIndex]['title'],
            // bottom: const TabBar(tabs: <Widget>[
            //   Tab(
            //     icon: Icon(Icons.category),
            //     text: 'Categories',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.star),
            //     text: 'Favourites',
            //   )
            // ]),
          ),
          // body: TabBarView(
          //     children: <Widget>[CategoriesScreen(), FavouritesScreen()]),
          body: _pages[_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: _selectedPageIndex,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.category),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.star),
                  label: 'Favourites')
            ],
          ),
        ));
  }
}
