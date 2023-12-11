import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_event.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_state.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/widgets/loading_animation.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final TextEditingController usernameTextController = TextEditingController(text: '');
  final TextEditingController passwordTextController = TextEditingController(text: '');
  final TextEditingController passwordConfirmTextController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/loginPicture.jpeg',
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _getLogoWidget(),
                  _getRegisterWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLogoWidget() {
    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.asset(
              'assets/images/registerLogo.jpg',
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _getRegisterWidget(BuildContext context) {
    return SizedBox(
      height: 440,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            _getDataTextField(
              title: 'نام کاربری',
              controller: usernameTextController,
            ),
            const SizedBox(
              height: 10,
            ),
            _getDataTextField(
              title: 'رمز عبور',
              controller: passwordTextController,
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            _getDataTextField(
              title: 'تکرار رمز عبور',
              controller: passwordConfirmTextController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            _getRegisterButton(context),
            const SizedBox(
              height: 10,
            ),
            _getRegisterErrorProvider(),
            const Spacer(),
            _getLoginText(context),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDataTextField({
    required String title,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SB',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            style: const TextStyle(fontFamily: 'GB'),
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: CustomColors.grey.withOpacity(0.3),
              border: InputBorder.none,
              constraints: const BoxConstraints(
                maxWidth: 340,
                maxHeight: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRegisterButton(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationRegisterRequestEvent(
                usernameTextController.text,
                passwordTextController.text,
                passwordConfirmTextController.text,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            fixedSize: const Size(140, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: (state is AuthenticationLoadingState)
              ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: LoadingAnimation(
                    color: CustomColors.backgroundScreenColor,
                  ),
                )
              : const Text(
                  'ثبت نام',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 18,
                  ),
                ),
        );
      },
    );
  }

  Widget _getRegisterErrorProvider() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationResponseState) {
          return state.response.fold(
            (error) => const Text(
              'ثبت نام شما انجام نشد، لطفا اطلاعات را با دقت پر کنید',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
            (success) => const Text(
              'ثبت نام با موفقیت انجام شد، خوش آمدید',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _getLoginText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Text(
        'بازگشت به صفحه ورود',
        style: TextStyle(
          fontFamily: 'SB',
          fontSize: 14,
        ),
      ),
    );
  }
}
