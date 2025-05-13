import 'package:client_side/core/theme/app_pallete.dart';
import 'package:client_side/core/utils.dart';
import 'package:client_side/core/widgets/loader.dart';
import 'package:client_side/features/auth/view/pages/login.dart';
import 'package:client_side/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client_side/features/auth/view/widgets/custom_field.dart';
import 'package:client_side/features/auth/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
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
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackBar(context, 'Account created! please login');

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
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
                        if (formKey.currentState!.validate()) {
                          ref.read(authViewModelProvider.notifier).signUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text);
                        } else {
                          showSnackBar(context, 'Fields missing');
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
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
