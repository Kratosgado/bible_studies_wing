import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../functions.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const routeName = '/signinpage';

  @override
  Widget build(BuildContext context) {
    // final appState = ref.read(applicationState.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register A Member"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color.fromARGB(255, 202, 214, 224),
        //       Colors.white,
        //       Colors.white,
        //       Colors.white,
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 200, horizontal: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "BIBLE STUDY WING",
                style: TextStyle(
                  fontSize: 25,
                  color: ColorManager.bgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: ColorManager.bgColor,
                  elevation: Spacing.s10,
                  splashColor: Colors.teal,
                  hoverElevation: Spacing.s20,
                  hoverColor: Colors.teal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.googleimage),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Sign in with Google",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  onPressed: () {
                    signInWithGoogle(context);
                    // appState.signInWithGoogle(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
