import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_screen_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSendPressed() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenScaffold(
      appBar: AppBar(leading: BackButton(onPressed: () => context.go('/login'))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Text(
              'Mot de passe oublié ?',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Entrez votre email, nous vous enverrons un lien pour réinitialiser votre mot de passe.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            if (_emailSent) ...[
              const Icon(
                Icons.mark_email_read_outlined,
                size: 56,
                color: AppColors.accent,
              ),
              const SizedBox(height: 16),
              Text(
                'Email envoyé ! Vérifiez votre boîte de réception pour continuer.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ] else ...[
              Form(
                key: _formKey,
                child: AuthTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: Validators.email,
                  autofillHints: const [AutofillHints.email],
                ),
              ),
              const SizedBox(height: 24),
              AuthButton(
                label: 'Envoyer le lien',
                isLoading: _isLoading,
                onPressed: _onSendPressed,
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
