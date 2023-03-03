import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme.dart';
import '../../../widgets/deafult_loading.dart';
import '../../../widgets/default_appbar.dart';
import '../../../widgets/rounded_button.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_text_field.dart';
import 'signup_view.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const LoginView(),
  );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final appBar = DefaultAppBar.appBar();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    ref.read(authControllerProvider.notifier).login(
      context: context, 
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading ? const DefaultLoading() : Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget> [
                const SizedBox(height: 25),
                AuthTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedButton(
                    onPressed: () => login(), 
                    label: 'Login',
                  ),
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: <InlineSpan> [
                      TextSpan(
                        text: ' Sign up',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Pallete.blueColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.of(context).pushReplacement(
                            SignUpView.route()
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}