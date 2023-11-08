import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routers/app_routes.dart';

class LoginAlertDialogWidget extends StatelessWidget {
  const LoginAlertDialogWidget({
    super.key,
    this.failureMessage,
  });
  final String? failureMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$failureMessage",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Email atau password yang anda masukan salah, Jika belum punya akun?, daftar sekarang!",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () => context.pop(),
          child: const Text(
            "Nanti",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: () => context.goNamed(AppRoutes.register),
          child: const Text(
            "Daftar",
            style: TextStyle(
              fontSize: 13,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
