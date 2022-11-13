import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:{{name.snakeCase()}}/app/types/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../../app/core/values/languages/translations.dart';
import '../../../app/services/localization.dart';
import '../../../app/types/image_theme.dart';
import '../../../app/types/size.dart';
import 'controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        // key: controller.formKey,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  color: LocalizationService.to.appColor,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: iconSizeM,
                  ),
                ),
                shadowColor: AppColors.noColor,
                backgroundColor: AppColors.noColor,
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),

                /// Bug: Vertical viewport was given unbounded height
                /// The following: https://stackoverflow.com/a/54587532/10621168
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: context.height * 0.12,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: marginSizeM * 2),
                      child: GFImageOverlay(
                          colorFilter: const ColorFilter.mode(
                              AppColors.noColor, BlendMode.colorBurn),
                          height: context.height * 0.15,
                          width: context.width * 0.8,
                          image: AssetImage(logoHeading(context)))),
                  SizedBox(
                    height: context.height * 0.05,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: marginSizeM),
                    child: FormBuilder(
                        key: controller.formKey,
                        onChanged: () {
                          controller.formKey.currentState!.save();
                          debugPrint(controller.formKey.currentState!.value
                              .toString());
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: marginSizeM,
                                  vertical: marginSizeM),
                              child: GFBorder(
                                radius: const Radius.circular(marginSizeM),
                                color: LocalizationService.to.appColor,
                                dashedLine: const [2, 0],
                                type: GFBorderType.rRect,
                                child: FormBuilderTextField(
                                  focusNode: controller.emailFocusNode,
                                  name: 'email',
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  // key: controller.emailFieldKey,
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                    labelStyle: styleCompatibleX(context),
                                    labelText: AppTranslations.email,
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.email(),
                                  ]),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: marginSizeM,
                                  vertical: marginSizeM),
                              child: GFBorder(
                                radius: const Radius.circular(marginSizeM),
                                color: LocalizationService.to.appColor,
                                dashedLine: const [2, 0],
                                type: GFBorderType.rRect,
                                child: FormBuilderTextField(
                                  focusNode: controller.passwordFocusNode,
                                  textInputAction: TextInputAction.send,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  name: 'password',
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                      labelStyle: styleCompatibleX(context),
                                      border: InputBorder.none,
                                      labelText: AppTranslations.password,
                                      prefixIcon: const Icon(
                                        Icons.password,
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: IconButton(
                                        color: Colors.grey,
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          !controller.obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          controller.changeObscureText();
                                        },
                                      )),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  obscureText: controller.obscureText,
                                ),
                              ),
                            ),
                            GFCheckboxListTile(
                              margin: const EdgeInsets.all(0),
                              listItemTextColor: textDark(context),
                              titleText: AppTranslations.rememberPassword,
                              size: iconSizeM,
                              activeBgColor: LocalizationService.to.appColor,
                              type: GFCheckboxType.circle,
                              activeIcon: const Icon(
                                Icons.check,
                                size: iconSizeS,
                                color: Colors.white,
                              ),
                              onChanged: (value) {
                                controller.changeRememberPassword(value);
                              },
                              value: controller.rememberPassword,
                              inactiveIcon: null,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: marginSizeM,
                                  vertical: marginSizeM),
                              child: GFButton(
                                size: GFSize.LARGE,
                                textStyle: styleX,
                                onPressed: () {
                                  controller.login(context);
                                },
                                text: AppTranslations.login,
                                fullWidthButton: true,
                                color: LocalizationService.to.appColor,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: marginSizeM),
                      child: Row(
                        children: [
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                AppTranslations.forgetPassword,
                                style: styleCompatibleX(context),
                              )),
                        ],
                      )),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
