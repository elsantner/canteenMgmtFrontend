import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Offstage(
        offstage: state.authenticated,
        child: ElevatedButton(
          child: const Text("Sign up"),
          onPressed: () => context.beamToNamed('/signup'),
        ),
      ),
    );
  }
}
