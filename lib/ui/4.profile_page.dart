import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            _pageTitle(),
            _userNameAndNumber(),
            const SizedBox(
              height: 30,
            ),
            _profileSettingIcons(),
            const Spacer(),
            _credits(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Container _pageTitle() {
    return Container(
      margin: const EdgeInsets.only(
        left: 44,
        right: 44,
        bottom: 32,
        top: 20,
      ),
      height: 46,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16,
          ),
          Image.asset('assets/images/icon_apple_blue.png'),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Text(
              'حساب کاربری',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColors.blue,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }
}

Column _userNameAndNumber() {
  return const Column(
    children: [
      Text(
        'محمدجواد هاشمی',
        style: TextStyle(
          fontFamily: 'SB',
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      Text(
        '09123456789',
        style: TextStyle(
          fontFamily: 'SB',
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget _profileSettingIcons() {
  return SizedBox(
    height: 300,
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 30,
          crossAxisSpacing: 35,
          mainAxisExtent: 80,
        ),
        itemBuilder: ((context, index) {
          return Column(
            children: [
              _listItemIcons(),
              const SizedBox(
                height: 5,
              ),
              _listItemTitles(),
            ],
          );
        }),
      ),
    ),
  );
}

Widget _listItemIcons() {
  return Container(
    height: 56,
    width: 56,
    decoration: ShapeDecoration(
      color: CustomColors.blue,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      shadows: const [
        BoxShadow(
          color: Colors.red,
          spreadRadius: -12,
          blurRadius: 40,
          offset: Offset(0, 15),
        ),
      ],
    ),
    child: const Icon(
      Icons.mouse,
      color: Colors.white,
      size: 32,
    ),
  );
}

Widget _listItemTitles() {
  return const Text(
    'همه',
    style: TextStyle(
      fontFamily: 'SM',
      fontSize: 14,
    ),
  );
}

Column _credits() {
  return const Column(
    children: [
      Text(
        'اپل شاپ',
        style: TextStyle(
          fontFamily: 'SM',
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
      Text(
        'v - 1.0.00',
        style: TextStyle(
          fontFamily: 'SM',
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
      Text(
        'instagram.com/mojava-dev',
        style: TextStyle(
          fontFamily: 'SM',
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
    ],
  );
}
