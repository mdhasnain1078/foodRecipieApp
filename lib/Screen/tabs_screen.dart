import 'package:flutter/material.dart';
import '../Screen/category_screen..dart';
import '../Screen/favotire_screen.dart';
import '../Widget/main_drawer.dart';
import '../models/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key, required this.favoriteMeals}) : super(key: key);
  final List<Meal> favoriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>>? pages;
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    pages = [
      {'page': CategoryScreen(), 'title': 'Categories'},
      {
        'page': FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Favorites'
      }
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages![_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: pages![_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          onTap: _selectedPage,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(
                  Icons.category,
                ),
                label: "Category"),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.star),
                label: "Favorite")
          ]),
    );
  }
}

//  this code is for creating tabs on the upper side of the screen
// return DefaultTabController(
//         length: 2,
//         initialIndex: 0,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text("Meals"),
//             bottom: const TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.category),
//                   text: "Categories",
//                 ),
//                 Tab(
//                   icon: Icon(Icons.star),
//                   text: "Favourite",
//                 )
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [CategoryScreen(), FavoriteScreen()],
//           ),
//         ));