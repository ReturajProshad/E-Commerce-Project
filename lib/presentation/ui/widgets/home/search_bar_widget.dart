import 'dart:math';
import 'package:crafty_bay_app/data/utility/all_apps.dart';
import 'package:crafty_bay_app/presentation/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onSearch;

  SearchBarWidget({required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  // ignore: prefer_final_fields
  TextEditingController _textController = TextEditingController();
  String searchValue = '';
  List<String> searchSuggestions = [];
  int productIdFromSearch = 0;
  Map<int, String> elements = appListClass.appLists;

  void updateSearch(String value) {
    setState(() {
      searchValue = value;
      searchSuggestions = getSearchSuggestions(value);
    });
  }

  List<int> pidS = [];
  List<String> getSearchSuggestions(String value) {
    List<String> suggestions = [];
    suggestions.clear();
    pidS.clear();
    if (value.isEmpty) return [];
    for (var element in elements.entries) {
      int distance = hamming_distance(value, element.value);
      if (distance < 2) {
        suggestions.add(element.value);
        pidS.add(element.key);
      }
    }
    return suggestions;
  }

  // ignore: non_constant_identifier_names
  String ConvToLow(String input) {
    String result = '';

    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      int asciiValue = char.codeUnitAt(0);
      if ((asciiValue >= 'a'.codeUnitAt(0) &&
              asciiValue <= 'z'.codeUnitAt(0)) ||
          (asciiValue >= 'A'.codeUnitAt(0) &&
              asciiValue <= 'Z'.codeUnitAt(0))) {
        result += char.toLowerCase();
      } else {
        result += char;
      }
    }

    return result;
  }

  // ignore: non_constant_identifier_names
  int hamming_distance(String string1, String string2) {
    int distCounter = 0;
    String s1 = ConvToLow(string1);
    String s2 = ConvToLow(string2);
    int l = min(string1.length, string2.length);
    for (int n = 0; n < l; n++) {
      if (s1[n] != s2[n]) distCounter += 1;
    }
    return distCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  updateSearch(value);
                  widget.onSearch(value);
                },
              ),
            ),
            if (_textController.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _textController.clear();
                  searchSuggestions.clear();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
          ],
        ),
        if (searchSuggestions.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: searchSuggestions.asMap().entries.map((entry) {
                final index = entry.key;
                final suggestion = entry.value;
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    // Print the index of the selected suggestion.
                    // print("Selected suggestion index: $index");
                    // print(pidS[index]);
                    searchValue = suggestion;
                    widget.onSearch(suggestion);
                    searchSuggestions.clear();
                    _textController.clear();
                    Get.to(ProductDetailsScreen(productId: pidS[index]));

                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
