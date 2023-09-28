import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_demo/presentation/components/form_component.dart';
import 'package:flutter_hooks_demo/presentation/controllers/auth_action_controller.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.pinkAccent, Colors.yellow, Colors.blue],
          ),
        ),
        child: HookConsumer(
          builder: (context, ref, _) {
            final authAction = ref.watch(authActionControllerProvider);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    height: 440,
                    width: 350,
                    margin: const EdgeInsets.all(8.0),
                    child: authAction == AuthAction.login ? FormComponent.login() : FormComponent.signUp(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
