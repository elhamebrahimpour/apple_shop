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
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'images/register_photo.png',
                  height: 160,
                  width: 160,
                ),
                const SizedBox(
                  height: 60,
                ),
                CredentialRegisterTextField(
                  userNameTextController: _userNameTextController,
                  passwordTextController: _passwordTextController,
                  passwordConfirmTextController: _passwordConfirmTextController,
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
        ),
      ),
    );
  }
}

class CredentialRegisterTextField extends StatelessWidget {
  const CredentialRegisterTextField({
    super.key,
    required TextEditingController userNameTextController,
    required TextEditingController passwordTextController,
    required TextEditingController passwordConfirmTextController,
  })  : _userNameTextController = userNameTextController,
        _passwordTextController = passwordTextController,
        _passwordConfirmTextController = passwordConfirmTextController;

  final TextEditingController _userNameTextController;
  final TextEditingController _passwordTextController;
  final TextEditingController _passwordConfirmTextController;

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
        const SizedBox(
          height: 20,
        ),
        const Text(
          'تکرار رمز عبور:',
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
            controller: _passwordConfirmTextController,
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
