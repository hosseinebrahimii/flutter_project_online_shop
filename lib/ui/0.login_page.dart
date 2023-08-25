import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_event.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_state.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController usernameTextController = TextEditingController(text: 'hosseinebrahimi1');
  final TextEditingController passwordTextController = TextEditingController(text: '123456789');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getLogoWidget(),
            _getLoginWidget(context),
          ],
        ),
      ),
    );
  }

  Expanded _getLogoWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon_application.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'اپل شاپ',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SB',
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _getLoginWidget(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getDataTextField(labelText: 'نام کاربری', controller: usernameTextController),
            const SizedBox(
              height: 20,
            ),
            _getDataTextField(labelText: 'رمز عبور', controller: passwordTextController),
            const SizedBox(
              height: 20,
            ),
            _getLoginResult(context),
          ],
        ),
      ),
    );
  }

  Widget _getDataTextField({required String labelText, required TextEditingController controller}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        style: const TextStyle(fontFamily: 'GB'),
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'SM',
            color: Colors.black,
            fontSize: 18,
          ),
          constraints: const BoxConstraints(
            maxWidth: 340,
            maxHeight: 50,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.blue,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLoginResult(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationInitiateState) {
          return ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLoginRequestEvent(
                  usernameTextController.text,
                  passwordTextController.text,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'ورود به حساب کاربری',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 18,
              ),
            ),
          );
        }
        if (state is AuthenticationLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is AuthenticationResponseState) {
          return state.response.fold(
            (l) => Text(l),
            (r) => const Text('شما وارد شده اید'),
          );
        }
        return const Text('خطای نامشخص');
      },
    );
  }
}
