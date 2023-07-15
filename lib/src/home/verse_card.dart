import 'package:flutter/material.dart';

Widget verseCard() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        SizedBox(
          height: 200,
          width: 350,
          child: Card(
            color: Colors.purple,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Image.asset(
              'assets/images/cards/card1.jpeg',
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
    ),
  );
}
