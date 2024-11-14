import 'package:flutter/material.dart';
import 'package:kasir_aplikasi/screens/signin_screen.dart';
import 'package:kasir_aplikasi/screens/signup_screen.dart';
import 'package:kasir_aplikasi/themes/theme.dart';
import 'package:kasir_aplikasi/widgets/custom_scaffold.dart';
import 'package:kasir_aplikasi/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
        children: [
          // Replace the RichText with an empty Container or keep as is
          Flexible(
            flex: 2,
            child: Container(), // You can keep it or add a logo/image
          ),
          // Centering the buttons
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                WelcomeButton(
                  buttonText: 'Sign in',
                  onTap: const SignInScreen(),
                  color: Colors.transparent,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20), 
                WelcomeButton(
                  buttonText: 'Sign up',
                  onTap: const SignUpScreen(),
                  color: Colors.white,
                  textColor: lightColorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
