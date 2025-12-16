import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../registration/registration_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Not logged in")),
      );
    }

    // PHASE 2: Always go to registration for now
    return RegistrationScreen(email: user.email!);
  }
}
