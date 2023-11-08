import 'package:flutter/material.dart';

class AppTitleAndTextFieldWidget extends StatelessWidget {
  const AppTitleAndTextFieldWidget({
    super.key,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.helper = const SizedBox.shrink(),
    this.hintText,
    this.initialValue,
    this.hintStyle,
    this.obscureText = false,
    this.onChanged,
    this.controller,
  });
  final String? title;
  final String? hintText;
  final String? initialValue;
  final bool readOnly;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget helper;
  final bool obscureText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty == true) Text("$title"),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            initialValue: initialValue,
            obscureText: obscureText,
            controller: controller,
            cursorColor: Colors.black,
            cursorWidth: 1,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        helper,
        const SizedBox(height: 12),
      ],
    );
  }
}
