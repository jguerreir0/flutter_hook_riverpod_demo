import 'package:flutter_hooks_demo/presentation/controllers/logout/logout_state.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:flutter_hooks_demo/services/firebase_auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogoutController extends StateNotifier<LogoutState> {
  final Ref ref;
  LogoutController(this.ref) : super(const LogoutStateInitial());

  void logout() async {
    state = const LogoutStateLoading();
    try {
      await ref.watch(firebaseAuthServiceProvider).logout();

      state = const LogoutStateSuccess();
    } catch (e) {
      state = LogoutStateFailure(errorMessage: (e as AuthException).errorMessage);
    }
  }
}
