// ignore_for_file: avoid_print
import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordConfirmTextController = TextEditingController();

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
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
                    SizedBox(
                      height: 52,
                      child: TextField(
                        controller: _passwordConfirmTextController,
                        decoration: const InputDecoration(
                          labelText: 'تکرار رمزعبور',
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
                                AuthRegisterRequest(
                                  _userNameTextController.text,
                                  _passwordTextController.text,
                                  _passwordConfirmTextController.text,
                                ),
                              );
                            },
                            child: const Text('ثبت نام'),
                          );
                        }
                        if (state is AuthLoadingState) {
                          return const CircularProgressIndicator(
                            color: AppColors.blueColor,
                            strokeWidth: 4,
                          );
                        }
                        /* if (state is AuthResponseState) {
                          state.response.fold(
                            (error) {},
                            (successfull) {},
                          );
                        }*/
                        return Container();
                      }),
                    ),
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
