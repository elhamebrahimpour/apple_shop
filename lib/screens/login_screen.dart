// ignore_for_file: must_be_immutable

import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/screens/register_screen.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apple_shop/screens/main_screens.dart';

import 'error_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _userNameTextController = TextEditingController(text: 'hamid');
  final _passwordTextController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/login_photo.jpg',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 60,
                ),
                CredentialTextField(
                  userNameTextController: _userNameTextController,
                  passwordTextController: _passwordTextController,
                ),
                const SizedBox(
                  height: 60,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: ((context, state) {
                    if (state is AuthInitialState) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'sb',
                          ),
                          minimumSize: const Size(210, 48),
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthLoginRequest(
                              _userNameTextController.text,
                              _passwordTextController.text,
                            ),
                          );
                        },
                        child: const Text('ورود به حساب کاربری'),
                      );
                    }
                    if (state is AuthLoadingState) {
                      return const CircularProgressIndicator(
                        color: AppColors.blueColor,
                        strokeWidth: 4,
                      );
                    }
                    if (state is AuthResponseState) {
                      state.response.fold(
                        (error) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ErrorScreen();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        (successfull) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const DashboardScreen();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    return Container();
                  }),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'آیا حساب کاربری ندارید؟',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'sb',
                        color: AppColors.greyColor,
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) {
                                  var authBloc = AuthBloc(
                                    serviceLocator.get(),
                                  );

                                  authBloc.stream.forEach(
                                    (currentState) {
                                      if (currentState is AuthResponseState) {
                                        currentState.response.fold(
                                          (error) => Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const ErrorScreen();
                                              },
                                            ),
                                          ),
                                          (response) => Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const DashboardScreen();
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );

                                  return authBloc;
                                },
                                child: RegisterScreen(),
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'ثبت نام',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'sb',
                          color: AppColors.blueColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CredentialTextField extends StatelessWidget {
  const CredentialTextField({
    super.key,
    required TextEditingController userNameTextController,
    required TextEditingController passwordTextController,
  })  : _userNameTextController = userNameTextController,
        _passwordTextController = passwordTextController;

  final TextEditingController _userNameTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نام کاربری:',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
            fontFamily: 'sm',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.2),
          ),
          child: TextField(
            controller: _userNameTextController,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'رمز عبور:',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
            fontFamily: 'sm',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.2),
          ),
          child: TextField(
            controller: _passwordTextController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
