import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_footer_link.dart';
import '../widgets/auth_screen_scaffold.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/google_sign_in_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(authControllerProvider.notifier).signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      final error = next.error;
      if (error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    });
    final isLoading = ref.watch(authControllerProvider).isLoading;

    return AuthScreenScaffold(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                'Créer un compte',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Commencez à suivre vos dépenses',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              AuthTextField(
                label: 'Nom complet',
                controller: _nameController,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validators.required(value, 'Le nom complet est requis'),
                autofillHints: const [AutofillHints.name],
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: Validators.email,
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Mot de passe',
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
                label: "S'inscrire",
                isLoading: isLoading,
                onPressed: _onRegisterPressed,
              ),
              const SizedBox(height: 24),
              const AuthDivider(),
              const SizedBox(height: 24),
              GoogleSignInButton(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signInWithGoogle(),
              ),
              const SizedBox(height: 32),
              AuthFooterLink(
                text: 'Déjà un compte ? ',
                linkText: 'Se connecter',
                onPressed: () => context.go('/login'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
