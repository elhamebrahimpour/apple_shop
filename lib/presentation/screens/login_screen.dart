// ignore_for_file: must_be_immutable

import 'package:apple_shop/business/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/features/di/api_di.dart';
import 'package:apple_shop/presentation/screens/register_screen.dart';
import 'package:apple_shop/features/utils/constants/app_colors.dart';
import 'package:apple_shop/features/utils/extensions/context_extension.dart';
import 'package:apple_shop/features/utils/messenger.dart';
import 'package:apple_shop/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apple_shop/presentation/screens/main_screens.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _userNameTextController = TextEditingController(text: 'hamid');
  final _passwordTextController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        serviceLocator.get(),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
                child: LoginView(
                    userNameTextController: _userNameTextController,
                    passwordTextController: _passwordTextController)),
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
    required TextEditingController userNameTextController,
    required TextEditingController passwordTextController,
  })  : _userNameTextController = userNameTextController,
        _passwordTextController = passwordTextController;

  final TextEditingController _userNameTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 9,
          left: 32,
          right: 32,
          bottom: 32,
        ),
        child: Column(
          children: [
            Image.asset(
              'images/login_photo.jpg',
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 60,
            ),
            CustomTextField(
              textEditingController: _userNameTextController,
              fieldString: 'نام کاربری:',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              textEditingController: _passwordTextController,
              fieldString: 'رمز عبور:',
              isPassword: true,
            ),
            const SizedBox(
              height: 60,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthResponseState) {
                  state.response.fold(
                    (error) {
                      _userNameTextController.clear();
                      _passwordTextController.clear();
                      Messenger.showErrorMessenger(context, error);
                    },
                    (successfull) {
                      context.navigateToScreen(
                        const DashboardScreen(),
                      );
                    },
                  );
                }
              },
              builder: (context, snapshot) {
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: ((context, state) {
                    if (state is AuthInitialState) {
                      return LoginActionButton(
                        userNameTextController: _userNameTextController,
                        passwordTextController: _passwordTextController,
                      );
                    }
                    if (state is AuthLoadingState) {
                      return const CircularProgressIndicator(
                        color: AppColors.blueColor,
                        strokeWidth: 4,
                      );
                    }
                    if (state is AuthResponseState) {
                      Widget widget = Container();

                      state.response.fold(
                        (error) {
                          widget = LoginActionButton(
                            userNameTextController: _userNameTextController,
                            passwordTextController: _passwordTextController,
                          );
                        },
                        (response) {
                          widget = const Icon(
                            Icons.check,
                            color: AppColors.blueColor,
                            size: 38,
                          );
                        },
                      );

                      return widget;
                    }
                    return Container();
                  }),
                );
              },
            ),
            const SizedBox(
              height: 42,
            ),
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
                    context.navigateToScreen(
                      RegisterScreen(),
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
    );
  }
}

class LoginActionButton extends StatelessWidget {
  const LoginActionButton({
    super.key,
    required TextEditingController userNameTextController,
    required TextEditingController passwordTextController,
  })  : _userNameTextController = userNameTextController,
        _passwordTextController = passwordTextController;

  final TextEditingController _userNameTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
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
}
