import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_demo/presentation/controllers/logout/logout_state.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AuthenticatedPage extends HookWidget {
  const AuthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticated User'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: HookConsumer(
        builder: (context, ref, child) {
          ref.listen(
            logoutControllerProvider,
            (_, state) {
              if (state is LogoutStateSuccess) {
                context.router.popUntilRoot();
              }
            },
          );

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Current user is ${FirebaseAuth.instance.currentUser?.email}'),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.watch(logoutControllerProvider.notifier).logout();
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
