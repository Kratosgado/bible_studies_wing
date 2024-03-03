import 'package:bible_studies_wing/src/data/network/auth.controller.dart';
import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    // final appState = ref.read(applicationState.notifier);
    return CurvedScaffold(
      title: "Register a Member",
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
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
                    AuthController.to.signInWithGoogle();
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
