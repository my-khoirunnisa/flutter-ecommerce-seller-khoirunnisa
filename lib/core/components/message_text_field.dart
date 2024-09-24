import 'package:flutter/material.dart';

import '../core.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String value) sendTap;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.sendTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.send,
      onFieldSubmitted: (value) {
        sendTap(value);
        controller.clear();
      },
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        suffixIconColor: AppColors.white,
        suffixIcon: IconButton(
          onPressed: () {
            sendTap(controller.text);
            controller.clear();
          },
          icon: const Icon(Icons.send),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.white),
      ),
    );
  }
}
