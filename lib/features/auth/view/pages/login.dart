import 'package:client_side/core/theme/app_pallete.dart';
import 'package:client_side/features/auth/repositories/auth_remote_repositories.dart';
import 'package:client_side/features/auth/view/pages/sign_up.dart';
import 'package:client_side/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client_side/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState!.validate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                  await AuthRemoteRepository().login(
                      email: emailController.text,
                      password: passwordController.text);
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
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
