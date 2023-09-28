import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_demo/presentation/controllers/auth_action_controller.dart';
import 'package:flutter_hooks_demo/presentation/controllers/login/login_state.dart';
import 'package:flutter_hooks_demo/presentation/controllers/signup/signup_state.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomGradientButton extends HookWidget {
  final VoidCallback onPressed;
  final String buttonLabel;

  ///Creates a Gradient Button Used for Login/Signup
  const CustomGradientButton({
    super.key,
    required this.onPressed,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(0.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.pinkAccent,
                Colors.orange.shade300,
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: HookConsumer(
            builder: (context, ref, _) {
              return Container(
                constraints: const BoxConstraints(minWidth: 90.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: _checkLoadingState(ref.watch(authActionControllerProvider), ref)
                    ? CircularProgressIndicator(color: Colors.grey.shade500)
                    : Text(
                        buttonLabel,
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _checkLoadingState(AuthAction authAction, WidgetRef ref) {
    switch (authAction) {
      case AuthAction.login:
        return ref.watch(loginControllerProvider) is LoginStateLoading;
      case AuthAction.signup:
        return ref.watch(signUpControllerProvider) is SignupStateLoading;
    }
  }
}
