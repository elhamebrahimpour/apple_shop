// ignore_for_file: avoid_print
import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                var either = await AuthenticationRepository()
                    .registerUser('hamid', '12345678', '12345678');
                either.fold((errorMessage) => print(errorMessage),
                    (responseMessage) => print(responseMessage));
              },
              child: const Text('register user'),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                var either = await AuthenticationRepository()
                    .loginUser('hamid', '12345678');
                //either.fold((errorMessage) => print(errorMessage),(responseMessage) => print(responseMessage));
              },
              child: const Text('login user'),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                AuthManager.logOut();
              },
              child: const Text('logout user'),
            ),
            const SizedBox(
              height: 32,
            ),
            ValueListenableBuilder(
              valueListenable: AuthManager.valueNotifier,
              builder: ((context, value, child) {
                /*return AuthManager.isUserLoggedin()
                    ? const Text('user loggedin successfully!')
                    : const Text('user not loggedin...');*/
                if (value == null || value.isEmpty) {
                  return const Text('user not loggedin...');
                } else {
                  return const Text('user loggedin successfully!');
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
