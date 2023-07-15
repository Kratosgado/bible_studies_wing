import 'package:bible_studies_wing/src/home/home_drawer.dart';
import 'package:bible_studies_wing/src/home/verse_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = "/HomeView";

  @override
  Widget build(BuildContext context) {
    final cardList = [verseCard(), verseCard(), verseCard()];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Verse View'),
        ),
        drawer: homeDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: cardList,
          ),
        ));
  }
}
