import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_screen_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.token});

  final String? token;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onResetPressed() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: utiliser widget.token lors de l'appel API de réinitialisation.
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenScaffold(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                'Réinitialiser le mot de passe',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choisissez un nouveau mot de passe',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              AuthTextField(
                label: 'Nouveau mot de passe',
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.next,
                validator: Validators.newPassword,
                autofillHints: const [AutofillHints.newPassword],
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Confirmer le mot de passe',
                controller: _confirmPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (value) => Validators.confirmPassword(
                  value,
                  _passwordController.text,
                ),
                autofillHints: const [AutofillHints.newPassword],
              ),
              const SizedBox(height: 24),
              AuthButton(
                label: 'Réinitialiser le mot de passe',
                isLoading: _isLoading,
                onPressed: _onResetPressed,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
