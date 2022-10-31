import 'package:flutter/material.dart';
import 'package:navigation/dummy_data.dart';

class MealRecipiScreen extends StatelessWidget {
  const MealRecipiScreen(
      {super.key, required this.togggleFavorite, required this.isFavorite});

  static const routeName = "meal - recipie";
  final Function togggleFavorite;
  final Function isFavorite;

  Widget buildSelectionTitle(title) {
    return Container(
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "RobotoCondensed",
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });
    return Scaffold(
        appBar: AppBar(title: Text("${selectedMeal.title}")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              buildSelectionTitle("Ingredient"),
              buildContainer(
                ListView.builder(
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(selectedMeal.ingredients[index]),
                          ));
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              buildSelectionTitle("Steps"),
              buildContainer(
                ListView.builder(
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${index + 1}'),
                            ),
                            title: Text(selectedMeal.steps[index]),
                          ),
                          const Divider()
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            togggleFavorite(mealId);
          },
          child: Icon(
              // Icons.delete
              isFavorite(mealId) ? Icons.star : Icons.star_border),
        ));
  }
}
