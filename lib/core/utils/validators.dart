/// Generic client-side form validators shared across the auth screens.
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return "L'email est requis";
    if (!_emailRegex.hasMatch(value.trim())) return 'Email invalide';
    return null;
  }

  static String? requiredPassword(String? value) {
    if (value == null || value.isEmpty) return 'Le mot de passe est requis';
    return null;
  }

  static String? newPassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return 'Le mot de passe est requis';
    if (value.length < minLength) return 'Au moins $minLength caractères';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Confirmez votre mot de passe';
    if (value != original) return 'Les mots de passe ne correspondent pas';
    return null;
  }
}
