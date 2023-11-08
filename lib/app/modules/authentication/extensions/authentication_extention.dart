enum AuthError {
  nameEmpty,
  emailEmpty,
  passwordEmpty,
  invalidEmail,
  invalidPassword,
  passwordTooShort,
}

bool isEmailValid(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(email);
}

extension AuthErrorExtention on AuthError {
  String get message {
    switch (this) {
      case AuthError.nameEmpty:
        return 'Nama kamu tidak boleh kosong ya!';
      case AuthError.emailEmpty:
        return 'Email Tidak boleh kosong ya!';
      case AuthError.passwordEmpty:
        return 'Password Tidak boleh kosong ya!';
      case AuthError.invalidEmail:
        return 'Email kamu tidak valid nih!';
      case AuthError.invalidPassword:
        return 'Password kamu tidak valid nih!';
      case AuthError.passwordTooShort:
        return 'Password kamu harus lebih dari 6 karakter ya!';
      default:
        return '';
    }
  }
}
