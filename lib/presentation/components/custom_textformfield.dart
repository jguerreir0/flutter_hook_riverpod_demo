import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_demo/presentation/utils/form_validator_extension.dart';

class CustomTextFormField extends HookWidget {
  final String hintText;
  final TextEditingController controller;
  final bool hasSuffixIcon;
  final bool isObscureText;
  final VoidCallback? onSuffixIconTap;
  final String? Function(String?) validator;

  const CustomTextFormField._({
    required this.hintText,
    required this.controller,
    this.hasSuffixIcon = false,
    this.isObscureText = true,
    this.onSuffixIconTap,
    required this.validator,
  });

  ///Creates TextFormField for Password
  factory CustomTextFormField.password({
    required TextEditingController passwordController,
    required VoidCallback? onSuffixIconTap,
    required bool isObscureText,
  }) =>
      CustomTextFormField._(
        hintText: 'Password',
        controller: passwordController,
        hasSuffixIcon: true,
        onSuffixIconTap: onSuffixIconTap,
        isObscureText: isObscureText,
        validator: (input) => input.isValidPassword() ? null : 'Please enter a valid password',
      );

  ///Creates TextFormField for Email
  factory CustomTextFormField.email({required TextEditingController emailController, required}) =>
      CustomTextFormField._(
        hintText: 'Email Address',
        controller: emailController,
        validator: (input) => input.isValidEmail() ? null : "Please enter a valid Email",
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: !isObscureText,
        validator: validator,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          focusedBorder: _getBorderStyle(color: Colors.grey.shade700),
          enabledBorder: _getBorderStyle(),
          border: _getBorderStyle(),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          suffixIcon: hasSuffixIcon
              ? IconButton(
                  onPressed: onSuffixIconTap,
                  icon: Icon(
                    isObscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  ),
                )
              : null,
          hintText: hintText,
        ),
      ),
    );
  }

  OutlineInputBorder _getBorderStyle({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          width: 2,
          color: color ?? Colors.grey.shade400,
        ),
      );
}
