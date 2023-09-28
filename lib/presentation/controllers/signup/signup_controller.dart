import 'package:flutter_hooks_demo/presentation/controllers/signup/signup_state.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:flutter_hooks_demo/services/firebase_auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupController extends StateNotifier<SignupState> {
  final Ref ref;
  SignupController(this.ref) : super(const SignupStateInitial());

  void signup(String email, String password) async {
    state = const SignupStateLoading();
    try {
      await ref.watch(firebaseAuthServiceProvider).signUp(email, password);

      state = const SignupStateSuccess();
    } catch (e) {
      state = SignupStateFailure(errorMessage: (e as AuthException).errorMessage);
    }
  }
}
