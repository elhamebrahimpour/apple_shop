// ignore_for_file: avoid_print
import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/screens/login_screen.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:apple_shop/utils/extensions/context_extension.dart';
import 'package:apple_shop/utils/messenger.dart';
import 'package:apple_shop/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screens.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordConfirmTextController = TextEditingController();

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
              child: RegisterView(
                userNameTextController: _userNameTextController,
                passwordTextController: _passwordTextController,
                passwordConfirmTextController: _passwordConfirmTextController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({
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
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 12,
        left: 32,
        right: 32,
      ),
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
            height: 20,
          ),
          CustomTextField(
            textEditingController: _passwordConfirmTextController,
            fieldString: 'تکرار رمز عبور:',
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
                    _passwordConfirmTextController.clear();
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
                    return RegisterActionButton(
                      userNameTextController: _userNameTextController,
                      passwordTextController: _passwordTextController,
                      passwordConfirmTextController:
                          _passwordConfirmTextController,
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
                        widget = RegisterActionButton(
                          userNameTextController: _userNameTextController,
                          passwordTextController: _passwordTextController,
                          passwordConfirmTextController:
                              _passwordConfirmTextController,
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
                'آیا حساب کاربری دارید؟',
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
                    LoginScreen(),
                  );
                },
                child: const Text(
                  'ورود',
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
    );
  }
}

class RegisterActionButton extends StatelessWidget {
  const RegisterActionButton({
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
}
