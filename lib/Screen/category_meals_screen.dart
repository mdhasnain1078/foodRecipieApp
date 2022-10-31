import 'package:flutter/material.dart';
import 'package:navigation/Widget/meal_item.dart';
import 'package:navigation/models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "category-meales";
  final List<Meal> availableMeals;
  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadedInitData = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   final routeArgs =
  //       ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  //   final categoryTitle = routeArgs["title"];
  //   final categoryId = routeArgs["id"];
  //   final categoryMeals = DUMMY_MEALS.where((meal) {
  //     return meal.categories.contains(categoryId);
  //   }).toList();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"];
      final categoryId = routeArgs["id"];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  // const CategoryMealsScreen(
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            categoryTitle!,
            style: const TextStyle(fontFamily: "Raleway"),
          ),
        ),
        body: ListView.builder(
            itemCount: displayedMeals!.length,
            itemBuilder: (context, index) {
              return MealItem(
                id: displayedMeals![index].id,
                imageUrl: displayedMeals![index].imageUrl,
                title: displayedMeals![index].title,
                affordability: displayedMeals![index].affordability,
                complexity: displayedMeals![index].complexity,
                duration: displayedMeals![index].duration,
                // removeItem: _removeMeal,
              );
            }));
  }
}
