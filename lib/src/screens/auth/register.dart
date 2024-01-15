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
        shape: StadiumBorder(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 202, 214, 224),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Card(
          margin: const EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "BIBLE STUDY WING",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: const Color.fromARGB(255, 202, 214, 224),
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/googleimage.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("Sign in with Google"),
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
