import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm_flutter_task/config/constants/pallete.dart';
import 'package:minapharm_flutter_task/config/routes/routes.dart';
import 'package:minapharm_flutter_task/presentation/screens/dashboard/dashboard.dart';
import 'package:minapharm_flutter_task/presentation/widgets/auth_btn.dart';
import 'package:minapharm_flutter_task/presentation/widgets/auth_text_form_field.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../widgets/progress_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool passwordIsVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.blue.shade50,
            ),
            Positioned(
                top: 140,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(44),
                        topRight: Radius.circular(44),
                      ),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('create an account , it\'s free!',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w300)),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 44,
                                ),
                                AuthTextFormField(
                                  inputType: TextInputType.text,
                                  fieldIcon: const Icon(Icons.account_circle),
                                  hint: 'enter your name',
                                  suffixIcon: null,
                                  controller: nameController,
                                  onValidate: (value) {
                                    if (value == null || value.length < 3) {
                                      return 'please enter a valid name "must be more than or equal 3 char"';
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                AuthTextFormField(
                                  inputType: TextInputType.emailAddress,
                                  fieldIcon: const Icon(Icons.account_circle),
                                  hint: 'enter your email',
                                  suffixIcon: null,
                                  controller: userNameController,
                                  onValidate: (value) {
                                    if (value == null || !value.contains("@")) {
                                      return 'please enter a valid email';
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                AuthTextFormField(
                                  inputType: TextInputType.text,
                                  fieldIcon: const Icon(Icons.lock),
                                  hint: 'enter your password',
                                  isPassword: passwordIsVisible,
                                  controller: passwordController,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passwordIsVisible =
                                              !passwordIsVisible;
                                        });
                                      },
                                      child: passwordIsVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  onValidate: (value) {
                                    if (value == null || value.length < 6) {
                                      return 'please password must be more than 6 char';
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                AuthTextFormField(
                                  inputType: TextInputType.text,
                                  fieldIcon: const Icon(Icons.lock),
                                  hint: 'confirm your password',
                                  isPassword: passwordIsVisible,
                                  controller: confirmPasswordController,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passwordIsVisible =
                                              !passwordIsVisible;
                                        });
                                      },
                                      child: passwordIsVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  onValidate: (value) {
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      return 'password and confirm password must be identical';
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                AuthButton(
                                  btnTitle: "Register",
                                  onPressed: () {
                                    _formKey.currentState!.save();
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .register(
                                              name: nameController.text,
                                              userName: userNameController.text,
                                              password:
                                                  passwordController.text);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      ' have an account ? ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.login);
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: Pallete.blue),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocListener<AuthCubit, AuthState>(
                          listenWhen: ((previous, current) =>
                              previous != current),
                          listener: (context, state) {
                            if (state is AuthLoading) {
                              showProgressIndicator(context);
                            } else if (state is LoginFailure) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMsg)),
                              );
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.dashboard, (route) => false);
                            }
                          },
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
