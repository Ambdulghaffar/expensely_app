import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Horizontal "ou" divider with a line on either side.
class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, this.label = 'ou'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
