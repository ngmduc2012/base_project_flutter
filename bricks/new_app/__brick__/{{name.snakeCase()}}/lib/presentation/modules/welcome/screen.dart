import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:{{name.snakeCase()}}/app/core/values/languages/translations.dart';
import '../../../app/core/routes/routes.dart';
import '../../../app/services/localization.dart';
import '../../../app/types/colors.dart';
import '../../../app/types/image_theme.dart';
import '../../../app/types/size.dart';
import '../../../app/types/text_style.dart';
import 'controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var slideList = [
      GFImageOverlay(
        width: MediaQuery.of(context).size.width,
        image: const AssetImage(intro_1),
        boxFit: BoxFit.cover,
        colorFilter:
            const ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: marginSizeM * 3, left: marginSizeM * 3),
              child: Text(
                AppTranslations.welcome,
                style: styleXL,
              ),
            ),
          ],
        ),
      ),
      GFImageOverlay(
        width: MediaQuery.of(context).size.width,
        image: const AssetImage(intro_2),
        boxFit: BoxFit.cover,
        colorFilter:
            const ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
      ),
      GFImageOverlay(
        width: MediaQuery.of(context).size.width,
        image: const AssetImage(intro_3),
        boxFit: BoxFit.cover,
        colorFilter:
            const ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
      ),
      GFImageOverlay(
        width: MediaQuery.of(context).size.width,
        image: const AssetImage(intro_4),
        boxFit: BoxFit.cover,
        colorFilter:
            const ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
      ),
      GFImageOverlay(
        width: MediaQuery.of(context).size.width,
        image: const AssetImage(intro_5),
        boxFit: BoxFit.cover,
        colorFilter:
            const ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
      ),
    ];

    /// Cách sử dụng page controller: https://api.flutter.dev/flutter/widgets/PageController-class.html
    PageController pageController = PageController(initialPage: 0);

    return GetBuilder<WelcomeController>(
      builder: (controller) {
        return SafeArea(
            child: Stack(children: <Widget>[
          Scaffold(
            backgroundColor: colorCompatible(context),
            body: GFIntroScreen(
              slides: slideList,
              pageController: pageController,
              introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
                pageController: pageController,
                pageCount: slideList.length,
                currentIndex: pageController.initialPage,
                backButtonText: '',
                forwardButtonText: '',
                skipButtonText: '',
                doneButtonText: '',
                showButton: false,
                navigationBarHeight: marginSizeM * 4,
                navigationBarWidth: context.width,
                navigationBarShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                navigationBarColor: AppColors.noColor,
                showDivider: false,
                dotHeight: marginSizeM,
                dotWidth: marginSizeM,
                dotShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                inactiveColor: Colors.grey[200]!,
                activeColor:  LocalizationService.to.appColor,
                dotMargin: const EdgeInsets.symmetric(horizontal: marginSizeS),
                showPagination: true,
              ),
              currentIndex: 0,
              pageCount: 5,
            ),
          ),
          Positioned(
            /// Dùng để nổi nút trên keyboard: https://stackoverflow.com/a/56932251/10621168
            // bottom: MediaQuery.of(context).viewInsets.bottom,
            bottom: marginSizeM * 5,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFButton(
                  buttonBoxShadow: true,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  text: AppTranslations.login,
                  textStyle: styleX,
                  color:  LocalizationService.to.appColor,
                  type: GFButtonType.solid,
                  blockButton: true,
                  size: GFSize.LARGE,
                ),
                GFButton(
                  // colorScheme: Theme.of(context).colorScheme,
                  buttonBoxShadow: true,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    Get.toNamed(Routes.SIGN_UP);
                  },
                  text: AppTranslations.signUp,
                  textStyle: styleCompatibleX(context),
                  color: colorCompatible(context),
                  // type: GFButtonType.outline2x,
                  blockButton: true,
                  size: GFSize.LARGE,
                  fullWidthButton: true,
                ),
              ],
            ),
          ),
        ]));
      },
    );
  }
}
