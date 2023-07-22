import 'package:flutter/material.dart';

Widget verseCard(BuildContext context) {
  return SizedBox(
    height: 300,
    width: 350,
    child: Card(
        shadowColor: Colors.purple,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/cards/card1.jpeg',
              fit: BoxFit.contain,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  iconSize: 35,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message_rounded),
                  iconSize: 35,
                )
              ],
            ),
          ],
        )),
  );
}
