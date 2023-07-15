import 'package:bible_studies_wing/src/home/home_drawer.dart';
import 'package:bible_studies_wing/src/home/verse_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = "/HomeView";

  @override
  Widget build(BuildContext context) {
    final cardList = [verseCard(), verseCard(), verseCard(), verseCard(), verseCard()];

    return Scaffold(
        appBar: AppBar(
          title: const Text('The Word'),
        ),
        drawer: homeDrawer(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: homeGradient,
            child: Center(
              child: Column(
                children: cardList,
              ),
            ),
          ),
        ));
  }
}
