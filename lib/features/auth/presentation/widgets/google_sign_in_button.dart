import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Outline button with the official Google logo, used to trigger Google
/// sign-in.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/images/icons/google_logo.svg',
        width: 20,
        height: 20,
      ),
      label: const Text('Continuer avec Google'),
    );
  }
}
