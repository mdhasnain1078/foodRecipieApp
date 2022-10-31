import 'package:flutter/material.dart';
import 'package:navigation/models/meals.dart';
import '../Widget/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.favoriteMeals});
  final List favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
          child: Text("you have no favorites yet - start adding some"));
    } else {
      return ListView.builder(
          itemCount: favoriteMeals.length,
          itemBuilder: (context, index) {
            return MealItem(
              id: favoriteMeals[index].id,
              imageUrl: favoriteMeals[index].imageUrl,
              title: favoriteMeals[index].title,
              affordability: favoriteMeals[index].affordability,
              complexity: favoriteMeals[index].complexity,
              duration: favoriteMeals[index].duration,
            );
          });
    }
  }
}
