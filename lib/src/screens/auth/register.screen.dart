import 'package:bible_studies_wing/src/data/network/auth.controller.dart';
import 'package:bible_studies_wing/src/resources/assets.manager.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/styles_manager.dart';
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
          elevation: Spacing.s1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Spacing.s140,
                // padding: const EdgeInsets.all(Spacing.s5),faintWhite
                margin: const EdgeInsets.all(3),
                alignment: Alignment.center,
                decoration: StyleManager.boxDecoration.copyWith(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                    radius: Spacing.s90, backgroundImage: AssetImage(ImageAssets.bslogo)),
              ),
              Text(
                "BIBLE STUDY WING",
                style: context.textTheme.titleMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.white,
                  elevation: Spacing.s1,
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
                        style: context.textTheme.titleMedium?.copyWith(color: ColorManager.bgColor),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await AuthController.to.signInWithGoogle();
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
