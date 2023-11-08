import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterAlertDialogWidget extends StatelessWidget {
  const RegisterAlertDialogWidget({
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
            "Email yang kamu masukan sudah terdaftar, coba menggunakan email lainnya",
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
            "Tutup",
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
