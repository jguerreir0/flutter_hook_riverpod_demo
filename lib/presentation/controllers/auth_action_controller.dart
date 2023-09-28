import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AuthAction { login, signup }

class AuthActionController extends StateNotifier<AuthAction> {
  AuthActionController() : super(AuthAction.login);

  void onTap() {
    switch (state) {
      case AuthAction.login:
        state = AuthAction.signup;
      case AuthAction.signup:
        state = AuthAction.login;
    }
  }
}
