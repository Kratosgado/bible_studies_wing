import 'package:flutter/material.dart';

Widget verseCard() {
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        SizedBox(
          height: 300,
          child: Card(
            child: Center(
              child: Text("data"),
            ),
          ),
        )
      ],
    ),
  );
}
