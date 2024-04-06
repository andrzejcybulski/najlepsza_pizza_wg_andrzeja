import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_wg_andrzeja/app/cubit/root_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            errorMessage = state.errorMessage.toString();
          }
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isCreatingAccount == true
                        ? 'Zarejestruj się'
                        : 'Zaloguj się'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: widget.emailController,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                    ),
                    TextField(
                      controller: widget.passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Hasło',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Text(errorMessage),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () async {
                        if (isCreatingAccount == true) {
                          // registration

                          await context
                              .read<RootCubit>()
                              .createUserWithEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                              );

                          //   await FirebaseAuth.instance
                          //       .createUserWithEmailAndPassword(
                          //           email: widget.emailController.text,
                          //           password: widget.passwordController.text);
                        } else {
                          // login

                          // try {
                          //   await context
                          //       .read<RootCubit>()
                          //       .signUpWithEmailAndPassword(
                          //         email: widget.emailController.text,
                          //         password: widget.passwordController.text,
                          //       );

                          //   // await FirebaseAuth.instance.signInWithEmailAndPassword(
                          //   //     email: widget.emailController.text,
                          //   //     password: widget.passwordController.text);
                          // } catch (error) {
                          //   setState(
                          //     () {
                          //       errorMessage = error.toString();
                          //     },
                          //   );
                          // }

                          await context
                              .read<RootCubit>()
                              .signUpWithEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                              );
                        }
                      },
                      child: Text(isCreatingAccount == true
                          ? 'Zarejestruj się'
                          : 'Zaloguj się'),
                    ),
                    const SizedBox(height: 20),
                    // TextButton(
                    //   onPressed: () {
                    //     if (isCreatingAccount == false) {
                    //       setState(
                    //         () {
                    //           isCreatingAccount = true;
                    //         },
                    //       );
                    //     } else {
                    //       setState(
                    //         () {
                    //           isCreatingAccount = false;
                    //         },
                    //       );
                    //     }
                    //   },
                    //   child: Text(isCreatingAccount == true
                    //       ? 'Masz już konto?'
                    //       : 'Utwórz konto'),
                    // ),
                    if (isCreatingAccount == false) ...[
                      TextButton(
                        onPressed: () {
                          setState(
                            () {
                              isCreatingAccount = true;
                            },
                          );
                        },
                        child: const Text('Utwórz konto'),
                      ),
                    ],
                    if (isCreatingAccount == true) ...[
                      TextButton(
                        onPressed: () {
                          setState(
                            () {
                              isCreatingAccount = false;
                            },
                          );
                        },
                        child: const Text('Masz już konto?'),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
