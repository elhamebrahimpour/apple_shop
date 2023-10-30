// ignore_for_file: must_be_immutable

import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
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
        backgroundColor: AppColors.blueColor,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/icon_application.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'اپل شاپ',
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 24,
                        fontFamily: 'sb'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 52,
                      child: TextField(
                        controller: _userNameTextController,
                        decoration: const InputDecoration(
                          labelText: 'نام کاربری',
                          labelStyle: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontFamily: 'sm'),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                                color: AppColors.blackColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.blueColor,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 52,
                      child: TextField(
                        controller: _passwordTextController,
                        decoration: const InputDecoration(
                          labelText: 'رمزعبور',
                          labelStyle: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontFamily: 'sm'),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                                color: AppColors.blackColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.blueColor,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: ((context, state) {
                        if (state is AuthInitialState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueColor,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'sb',
                              ),
                              minimumSize: const Size(200, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CredentialTextField extends StatelessWidget {
  CredentialTextField({
    Key? key,
    required this.textEditingController,
    required this.labelText,
  }) : super(key: key);

  TextEditingController textEditingController;
  String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
              color: AppColors.blackColor, fontSize: 16, fontFamily: 'sm'),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: AppColors.blackColor, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: AppColors.blueColor,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
