import 'package:flutter/material.dart';

/// Outline button with a Google mark, used to trigger Google sign-in.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Text(
        'G',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4285F4),
        ),
      ),
      label: const Text('Continuer avec Google'),
    );
  }
}
