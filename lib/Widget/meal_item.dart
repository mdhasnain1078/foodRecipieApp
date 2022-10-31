import 'package:flutter/material.dart';
import 'package:navigation/Screen/meal_recipi_screen.dart';
import 'package:navigation/models/meals.dart';

class MealItem extends StatefulWidget {
  MealItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
    // required this.removeItem
  });
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  bool isLoaded = false;

  // final Function removeItem;
  String get complexityText {
    switch (widget.complexity) {
      case Complexity.simple:
        return 'Simple';
        break;
      case Complexity.challenging:
        return "Challenging";
        break;
      case Complexity.hard:
        return "Hard";
        break;
      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    switch (widget.affordability) {
      case Affordability.affordable:
        return 'Affordable';
        break;
      case Affordability.pricey:
        return "Pricey";
        break;
      case Affordability.luxurious:
        return "Expensive";
        break;
      default:
        return "Unknown";
    }
  }

  bool loaded = false;

  selectedMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealRecipiScreen.routeName, arguments: widget.id)
        .then((result) {
      // if (result != null) {
      //   removeItem(result);
      // }
    });
  }

  isImageLoaded() {
    return Image.network(
      widget.imageUrl,
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            selectedMeal(context);
          },
          child: Column(children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: isImageLoaded()),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        widget.title,
                        style:
                            const TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(children: [
                    const Icon(Icons.schedule),
                    const SizedBox(
                      width: 6,
                    ),
                    Text("${widget.duration} min")
                  ]),
                  Row(children: [
                    const Icon(Icons.work),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(complexityText)
                  ]),
                  Row(children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(affordabilityText)
                  ]),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
