import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/core/utils.dart';
import '../../../theme/theme.dart';
import '../../../widgets/deafult_loading.dart';
import '../../../widgets/default_appbar.dart';
import '../../../widgets/rounded_button.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_text_field.dart';
import 'login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const SignUpView(),
  );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final appBar = DefaultAppBar.appBar();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && nameController.text.isNotEmpty) {
      ref.read(authControllerProvider.notifier).signUp(
        context: context, 
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );
      return;
    }

    showSnackBar(context: context, content: 'Complete all the fields ;)', isError: true);
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
                  controller: nameController,
                  hintText: 'Name',
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedButton(
                    onPressed: () => isLoading ? null : signUp(),
                    label: 'Done',
                  ),
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: <InlineSpan> [
                      TextSpan(
                        text: ' Login',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Pallete.blueColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.of(context).pushReplacement(
                            LoginView.route(),
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