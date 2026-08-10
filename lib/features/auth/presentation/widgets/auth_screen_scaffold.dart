import 'package:flutter/material.dart';

/// Common screen chrome shared by every auth screen: [Scaffold] + [SafeArea]
/// + consistent horizontal padding and a max content width for large screens.
class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({super.key, required this.child, this.appBar});

  final Widget child;
  final PreferredSizeWidget? appBar;

  static const double _maxContentWidth = 480;
  static const double _horizontalPadding = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
