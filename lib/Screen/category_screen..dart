import 'package:flutter/material.dart';
import 'package:navigation/Widget/category_item.dart';
import '../dummy_data.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     // backgroundColor: Colors.transparent,
    //     title: const Center(
    //         child: Text(
    //       "Delimeal",
    //       style: TextStyle(
    //           // color: Colors.black,
    //           fontFamily: "Raleway",
    //           fontWeight: FontWeight.bold),
    //     )),
    //     // elevation: 0.0,
    //   ),
    return GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map((catData) {
          return CategoryItem(
            title: catData.title,
            color: catData.color,
            id: catData.id,
          );
        }).toList());
    // );
  }
}
