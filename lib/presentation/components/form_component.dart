import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_demo/presentation/components/custom_gradient_button.dart';
import 'package:flutter_hooks_demo/presentation/components/custom_textformfield.dart';
import 'package:flutter_hooks_demo/presentation/components/rich_text_clickable_component.dart';
import 'package:flutter_hooks_demo/presentation/controllers/auth_action_controller.dart';
import 'package:flutter_hooks_demo/presentation/controllers/login/login_state.dart';
import 'package:flutter_hooks_demo/presentation/controllers/signup/signup_state.dart';
import 'package:flutter_hooks_demo/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormComponent extends HookWidget {
  final GlobalKey<FormState> formKey;
  final String description;
  final String richTextLabel;
  final String buttonLabel;

  const FormComponent._({
    required this.description,
    required this.formKey,
    required this.richTextLabel,
    required this.buttonLabel,
  });

  ///Creates the content displayed on the Login Page
  factory FormComponent.login() => FormComponent._(
        description: 'Please Login to Your Account',
        formKey: GlobalKey<FormState>(),
        richTextLabel: "Don't have an account? ",
        buttonLabel: 'Login',
      );

  ///Creates the content displayed on the Signup Page
  factory FormComponent.signUp() => FormComponent._(
        description: 'Please Register a new Account',
        formKey: GlobalKey<FormState>(),
        richTextLabel: "Already have an account? ",
        buttonLabel: 'Register',
      );

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return HookConsumer(
      builder: (context, ref, child) {
        final isPasswordVisible = ref.watch(visiblePasswordProvider);
        final isAuthActionLogin = ref.watch(authActionControllerProvider) == AuthAction.login;

        _initListener(
          ref,
          context,
          isAuthActionLogin ? loginControllerProvider : signUpControllerProvider,
          emailController,
          passwordController,
        );

        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Hello',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormField.email(
                emailController: emailController,
              ),
              CustomTextFormField.password(
                passwordController: passwordController,
                onSuffixIconTap: () => ref.read(visiblePasswordProvider.notifier).onTap(!isPasswordVisible),
                isObscureText: isPasswordVisible,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomGradientButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    isAuthActionLogin
                        ? ref
                            .watch(loginControllerProvider.notifier)
                            .login(emailController.text, passwordController.text)
                        : ref
                            .watch(signUpControllerProvider.notifier)
                            .signup(emailController.text, passwordController.text);
                  }
                },
                buttonLabel: buttonLabel,
              ),
              const SizedBox(
                height: 22,
              ),
              RichTextClickableComponent(
                richTextLabel: richTextLabel,
                onTap: () {
                  ref.watch(authActionControllerProvider.notifier).onTap();
                  _resetControllers(emailController, passwordController);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _displayErrorSnackbar(BuildContext context, String errorMessage) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 17),
          ),
          backgroundColor: Colors.red,
        ),
      );

  void _displaySuccessSnackbar(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Success',
            style: TextStyle(fontSize: 17),
          ),
          backgroundColor: Colors.green,
        ),
      );

  void _navigateToAutheticatedPage(BuildContext context) => context.router.pushNamed('/success');

  void _resetControllers(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    emailController.clear();
    passwordController.clear();
  }

  void _initListener<T>(
    WidgetRef ref,
    BuildContext context,
    ProviderListenable<T> provider,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    ref.listen<T>(
      provider,
      (_, state) {
        if (state is SignupStateFailure) {
          _displayErrorSnackbar(context, state.errorMessage);
        }

        if (state is SignupStateSuccess) {
          _displaySuccessSnackbar(context);
          _navigateToAutheticatedPage(context);
          _resetControllers(emailController, passwordController);
          ref.watch(authActionControllerProvider.notifier).onTap();
        }

        if (state is LoginStateFailure) {
          _displayErrorSnackbar(context, state.errorMessage);
        }

        if (state is LoginStateSuccess) {
          _displaySuccessSnackbar(context);
          _navigateToAutheticatedPage(context);
          _resetControllers(emailController, passwordController);
        }
      },
    );
  }
}
