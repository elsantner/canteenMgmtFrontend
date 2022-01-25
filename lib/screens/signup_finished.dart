import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../widgets/about_button.dart';

class SignupFinishedScreen extends StatelessWidget {
  const SignupFinishedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new profile'),
        actions: const [AboutButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile created successfully."
            )
          ],
        ),
      ),
    );
  }
}