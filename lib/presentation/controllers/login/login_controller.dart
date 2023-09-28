import 'package:flutter_hooks_demo/presentation/controllers/login/login_state.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:flutter_hooks_demo/services/firebase_auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;
  LoginController(this.ref) : super(const LoginStateInitial());

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.watch(firebaseAuthServiceProvider).login(email, password);

      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateFailure(errorMessage: (e as AuthException).errorMessage);
    }
  }
}
