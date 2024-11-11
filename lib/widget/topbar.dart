import 'package:flutter/material.dart';
import 'package:weather_news_app/widget/searchbar.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 6, child: Searchbar()),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Icon(Icons.menu, size: 30),
        )
      ],
    );
  }
}
