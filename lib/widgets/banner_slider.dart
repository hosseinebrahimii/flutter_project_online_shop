import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({
    super.key,
    required this.itemBuilder,
  });
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.9);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        _pageSlider(pageController, itemBuilder),
        Positioned(
          bottom: 10,
          child: _pageSliderIndicator(pageController),
        ),
      ],
    );
  }

  SizedBox _pageSlider(
    PageController pageController,
    Widget Function(BuildContext context, int index) itemBuilder,
  ) {
    return SizedBox(
      height: 177,
      child: PageView.builder(
        controller: pageController,
        itemCount: 3,
        itemBuilder: itemBuilder,
      ),
    );
  }

  SmoothPageIndicator _pageSliderIndicator(PageController pageController) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: const ExpandingDotsEffect(
        expansionFactor: 4,
        dotWidth: 6,
        dotHeight: 6,
        dotColor: Colors.white,
        activeDotColor: CustomColors.indicatorColor,
      ),
    );
  }
}
