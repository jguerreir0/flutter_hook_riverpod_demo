import 'package:flutter_hooks_demo/presentation/controllers/auth_action_controller.dart';
import 'package:flutter_hooks_demo/presentation/controllers/login/login_controller.dart';
import 'package:flutter_hooks_demo/presentation/controllers/login/login_state.dart';
import 'package:flutter_hooks_demo/presentation/controllers/logout/logout_controller.dart';
import 'package:flutter_hooks_demo/presentation/controllers/logout/logout_state.dart';
import 'package:flutter_hooks_demo/presentation/controllers/signup/signup_controller.dart';
import 'package:flutter_hooks_demo/presentation/controllers/signup/signup_state.dart';
import 'package:flutter_hooks_demo/presentation/controllers/visible_password_controller.dart';
import 'package:flutter_hooks_demo/services/firebase_auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final visiblePasswordProvider =
    StateNotifierProvider<VisiblePasswordController, bool>((_) => VisiblePasswordController());

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) => LoginController(ref));

final signUpControllerProvider = StateNotifierProvider<SignupController, SignupState>((ref) => SignupController(ref));

final logoutControllerProvider = StateNotifierProvider<LogoutController, LogoutState>((ref) => LogoutController(ref));

final authActionControllerProvider =
    StateNotifierProvider<AuthActionController, AuthAction>((_) => AuthActionController());
