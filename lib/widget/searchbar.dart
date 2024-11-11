import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          style: TextStyle(fontSize: 18),
          cursorColor: Colors.black,
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: "Search News",
              filled: true,
              fillColor: Colors.grey[200])),
    );
  }
}
