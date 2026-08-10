import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expensely_app/core/navigation/app_router.dart';
import 'package:expensely_app/main.dart';

/// Mimics a typical phone viewport (rather than the 800x600 default test
/// surface) so scrollable auth forms lay out realistically.
void _usePhoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('navigates through all 5 auth screens without runtime errors', (
    WidgetTester tester,
  ) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    // Onboarding screen is shown first.
    expect(find.text('Skip'), findsOneWidget);

    // Skip -> Login.
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Bon retour'), findsOneWidget);

    // Login -> Register via footer link.
    await tester.ensureVisible(find.text("S'inscrire"));
    await tester.tap(find.text("S'inscrire"));
    await tester.pumpAndSettle();
    expect(find.text('Créer un compte'), findsOneWidget);

    // Register -> Login via footer link.
    await tester.ensureVisible(find.text('Se connecter'));
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();
    expect(find.text('Bon retour'), findsOneWidget);

    // Login -> Forgot password.
    await tester.tap(find.text('Mot de passe oublié ?'));
    await tester.pumpAndSettle();
    expect(find.text('Envoyer le lien'), findsOneWidget);

    // Forgot password -> back to Login.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Bon retour'), findsOneWidget);
  });

  testWidgets('onboarding "Suivant" paginates through slides to Get Started', (
    WidgetTester tester,
  ) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    router.go('/onboarding');
    await tester.pumpAndSettle();

    expect(find.text('Suivre ses dépenses facilement'), findsOneWidget);

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Visualiser ses dépenses par catégorie'), findsOneWidget);

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Atteindre ses objectifs financiers'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Bon retour'), findsOneWidget);
  });

  testWidgets('reset password screen renders when reached with a token', (
    WidgetTester tester,
  ) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    router.go('/reset-password?token=abc123');
    await tester.pumpAndSettle();

    expect(find.text('Réinitialiser le mot de passe'), findsWidgets);
    expect(find.text('Nouveau mot de passe'), findsOneWidget);
  });

  testWidgets('login form shows validation errors for empty input', (
    WidgetTester tester,
  ) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    router.go('/login');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();

    expect(find.text("L'email est requis"), findsOneWidget);
    expect(find.text('Le mot de passe est requis'), findsOneWidget);
  });

  testWidgets('forgot password shows a confirmation after sending', (
    WidgetTester tester,
  ) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    router.go('/forgot-password');
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'test@example.com');
    await tester.tap(find.text('Envoyer le lien'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Email envoyé ! Vérifiez votre boîte de réception pour continuer.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'Google button renders the real SVG logo, footer links expose a click cursor',
    (WidgetTester tester) async {
      _usePhoneViewport(tester);
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      // Login: Google SVG logo present and footer link has a click cursor.
      router.go('/login');
      await tester.pumpAndSettle();
      expect(find.byType(SvgPicture), findsOneWidget);

      final loginLinkCursor = tester.widget<MouseRegion>(
        find.ancestor(
          of: find.text("S'inscrire"),
          matching: find.byType(MouseRegion),
        ),
      );
      expect(loginLinkCursor.cursor, SystemMouseCursors.click);

      // Register: Google SVG logo present and footer link has a click cursor.
      router.go('/register');
      await tester.pumpAndSettle();
      expect(find.byType(SvgPicture), findsOneWidget);

      final registerLinkCursor = tester.widget<MouseRegion>(
        find.ancestor(
          of: find.text('Se connecter'),
          matching: find.byType(MouseRegion),
        ),
      );
      expect(registerLinkCursor.cursor, SystemMouseCursors.click);
    },
  );
}
