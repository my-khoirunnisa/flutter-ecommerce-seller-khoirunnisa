import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'spaces.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final void Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final double borderRadius;
  final TextCapitalization textCapitalization;
  final String? helperText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.textInputAction,
    this.borderRadius = 8.0,
    this.textCapitalization = TextCapitalization.none,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(12.0),
        ],
        TextFormField(
          textCapitalization: textCapitalization,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.stroke),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.stroke),
            ),
            hintText: hintText ?? label,
            helperText: helperText,
          ),
        ),
      ],
    );
  }
}
