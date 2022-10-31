import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:navigation/Widget/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen(
      {super.key, required this.saveFilter, required this.currentFilters});
  static const routeName = "/filters";
  final Function saveFilter;
  final Map<String, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegeterian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text(subtitle),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Filters"),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    "gluten": _glutenFree,
                    "lactose": _lactoseFree,
                    "vegan": _vegan,
                    "vegetarian": _vegeterian
                  };
                  widget.saveFilter(selectedFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text("Adjust your meal selection",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile("Gluten Free",
                    "Only include gluten free mials", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Lactose Free",
                    "Only include lactose free mials",
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegeterian", "Only include vegeterian mials", _vegeterian,
                    (newValue) {
                  setState(() {
                    _vegeterian = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegan", "Only include vegan mials", _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
