import 'package:flutter/material.dart';
import './Screen/category_meals_screen.dart';
import './Screen/filter_screen.dart';
import './Screen/meal_recipi_screen.dart';
import './Screen/tabs_screen.dart';
import './dummy_data.dart';
import 'models/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"]! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"]! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"]! && !meal.isVegan) {
          return false;
        }
        if (_filters["vegetarian"]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _togggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Delimeals",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            ),
      ),
      // home: const CategoryScreen(),
      // initialRoute: "/",

      routes: {
        "/": (context) {
          return TabsScreen(
            favoriteMeals: _favoriteMeals,
          );
        },
        CategoryMealsScreen.routeName: (context) {
          return CategoryMealsScreen(
            availableMeals: _availableMeals,
          );
        },
        MealRecipiScreen.routeName: (context) {
          return MealRecipiScreen(
            togggleFavorite: _togggleFavorite,
            isFavorite: _isMealFavorite,
          );
        },
        FilterScreen.routeName: (context) {
          return FilterScreen(
            saveFilter: _setFilters,
            currentFilters: _filters,
          );
        }
      },

//  onGanerateRoute is use for those pages which is not register in routes, Given above
      // onGenerateRoute: (setting) {
      //   if (setting.name == "/meal - details") {
      //     return MaterialPageRoute(
      //         builder: (context) => const CategoryScreen());
      //   }
      // },

      //  when nothing is defined in routes then the UnknownRoute exacutes
      //  or app crashes

      // onUnknownRoute: (setting) {
      //   return MaterialPageRoute(builder: (context) => const CategoryScreen());
      // },
    );
  }
}
