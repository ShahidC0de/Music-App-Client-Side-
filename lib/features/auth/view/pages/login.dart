import 'package:client_side/core/theme/app_pallete.dart';
import 'package:client_side/core/utils.dart';
import 'package:client_side/core/widgets/loader.dart';
import 'package:client_side/features/auth/view/pages/sign_up.dart';
import 'package:client_side/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client_side/core/widgets/custom_field.dart';
import 'package:client_side/features/auth/view_model/auth_viewmodel.dart';
import 'package:client_side/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackBar(context, 'Welcome Back!');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (_) => false,
            );
          },
          error: (error, str) {
            showSnackBar(context, error.toString());
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In.',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      controller: passwordController,
                      hintText: 'Password',
                      isObsecure: true,
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      titleText: 'Sign In',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          ref.read(authViewModelProvider.notifier).login(
                              email: emailController.text,
                              password: passwordController.text);
                        } else {
                          showSnackBar(context, 'Missing fields');
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Pallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
