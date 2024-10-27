import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/onboarding/onboarding/widget/onboarding_button.dart';
import 'package:stu_teach/features/onboarding/onboarding/widget/onboarding_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final onBoardingTitle = ['Lingolab', 'Lingolab', 'Essential'];

  final onBoardingSubtitle = [
    "Ingliz tilini oson o'rganing ",
    "Ingliz tilini oson o'rganing ",
    "English words",
  ];
  final onBoardingChildSubtitle = [
    "O'zida o'zini tekshirish, gaplashish va yozish qobiliyatlarini oshirishga yordam beradi.",
    "Ingliz tili bilimlaringizni testlar, o'yinlar yordamida mustahkamlang.",
    "Lingolab yordamida \"Essential English words\" so'zlarini oson va o'ynab yod oling.",
  ];

  final onBoardingImages = [
    AppImages.imgRocket,
    AppImages.imgJyostik,
    AppImages.imgBook,
  ];

  void _onPageChanged(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLastPage = _currentIndex == onBoardingImages.length - 1;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(AppImages.onboardingBg),
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                    AppColors.grey1,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              child: PageView.builder(
                controller: _controller,
                onPageChanged: _onPageChanged,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: onBoardingImages.length,
                itemBuilder: (context, index) {
                  // Assuming the OnboardingItem widget works as expected
                  return OnboardingItem(
                    title: onBoardingTitle[index],
                    image: onBoardingImages[index],
                    description: onBoardingChildSubtitle[index],
                    opacity: _currentIndex == index, subtitle: onBoardingSubtitle[index],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 34, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 51), // Empty space for balance
                SmoothPageIndicator(
                  count: onBoardingImages.length,
                  controller: _controller,
                  effect: WormEffect(
                    type: WormType.normal,
                    activeDotColor: AppColors.primaryColor,
                    dotColor:
                     AppColors.grey2,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                OnboardingButton(
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.login, (_) => false);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 850),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
