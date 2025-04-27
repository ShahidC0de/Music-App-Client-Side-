import 'package:client_side/core/theme/app_pallete.dart';
import 'package:client_side/features/auth/repositories/auth_remote_repositories.dart';
import 'package:client_side/features/auth/view/pages/login.dart';
import 'package:client_side/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client_side/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                'Sign Up.',
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 30),
              CustomField(
                controller: nameController,
                hintText: 'Name',
              ),
              const SizedBox(height: 15),
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
                titleText: 'Sign Up',
                onPressed: () async {
                  final response = await AuthRemoteRepository().signUp(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  //    final val = switch (response) {
                  //   Left(value: final l) => l,
                  //   Right(value: final r) => r.toString(),
                  // };
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: RichText(
                    text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const [
                      TextSpan(
                          text: 'Sign In',
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
