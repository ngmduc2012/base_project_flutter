import 'dart:io';
import 'package:{{name.snakeCase()}}/app/core/values/languages/translations.dart';
import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:{{name.snakeCase()}}/app/types/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../app/services/localization.dart';
import '../../../app/types/size.dart';
import '../../../data/modles/gender_select.dart';
import '../../../data/modles/role_select.dart';
import '../../widgets/dialog/image_display.dart';
import 'controller.dart';

class SignUpScreen extends GetWidget<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) => Form(
        // key: controller.formKey,
        child: Stack(children: <Widget>[
          Scaffold(
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
                title: Text(
                  AppTranslations.signUp,
                  style: TextStyle(color: textDark(context)),
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
                                    child: GFAccordion(
                                        titlePadding: const EdgeInsets.all(0),
                                        contentPadding: const EdgeInsets.all(0),
                                        contentBackgroundColor:
                                        AppColors.noColor,
                                        expandedTitleBackgroundColor:
                                        AppColors.noColor,
                                        collapsedTitleBackgroundColor:
                                        AppColors.noColor,
                                        titleChild: GFListTile(
                                          padding: const EdgeInsets.all(0),
                                          margin: const EdgeInsets.all(0),
                                          avatar: const Icon(
                                            Icons.photo,
                                            color: Colors.grey,
                                          ),
                                          subTitle: Text(
                                            AppTranslations.selectAvatar,
                                            style: styleCompatibleX(context),
                                          ),
                                        ),
                                        contentChild: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GFListTile(
                                              padding: const EdgeInsets.only(
                                                  top: marginSizeM,
                                                  left: marginSizeX),
                                              margin: const EdgeInsets.all(0),
                                              avatar: const Icon(
                                                Icons.camera,
                                                color: Colors.grey,
                                              ),
                                              subTitle: Text(
                                                AppTranslations.takeThePhoto,
                                                style:
                                                styleCompatibleX(context),
                                              ),
                                              onTap: () {
                                                controller.getImage(
                                                    ImageSource.camera);
                                              },
                                            ),
                                            GFListTile(
                                              padding: const EdgeInsets.only(
                                                  top: marginSizeM,
                                                  left: marginSizeX),
                                              margin: const EdgeInsets.all(0),
                                              avatar: const Icon(
                                                Icons.image,
                                                color: Colors.grey,
                                              ),
                                              subTitle: Text(
                                                AppTranslations.library,
                                                style:
                                                styleCompatibleX(context),
                                              ),
                                              onTap: () {
                                                controller.getImage(
                                                    ImageSource.gallery);
                                              },
                                            ),
                                            GFListTile(
                                              padding: const EdgeInsets.only(
                                                  top: marginSizeM,
                                                  left: marginSizeX),
                                              margin: const EdgeInsets.all(0),
                                              avatar: const Icon(
                                                Icons.open_in_new,
                                                color: Colors.grey,
                                              ),
                                              subTitle: Text(
                                                AppTranslations.openImage,
                                                style:
                                                styleCompatibleX(context),
                                              ),
                                              onTap: () {
                                                Get.dialog(ImageDisplayDialog(
                                                    path: controller.avatar,
                                                    size: context.width * 0.8,
                                                    isAssetImage: controller
                                                        .isAssetImage));
                                              },
                                            ),
                                          ],
                                        ),
                                        collapsedIcon: GFAvatar(
                                            backgroundImage: controller
                                                .isAssetImage
                                                ? AssetImage(controller.avatar)
                                                : Image.file(
                                                File(controller.avatar))
                                                .image,
                                            shape: GFAvatarShape.standard),
                                        expandedIcon: GFAvatar(
                                            backgroundImage: controller
                                                .isAssetImage
                                                ? AssetImage(controller.avatar)
                                                : Image.file(
                                                File(controller.avatar))
                                                .image,
                                            shape: GFAvatarShape.standard)))),
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
                                  focusNode: controller.userNameFocusNode,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  name: 'userName',
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                    labelStyle: styleCompatibleX(context),
                                    border: InputBorder.none,
                                    labelText: AppTranslations.userName,
                                    prefixIcon: const Icon(
                                      Icons.perm_identity,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
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
                                  focusNode: controller.emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  name: 'email',
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
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
                                  textInputAction: TextInputAction.next,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
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
                                  focusNode: controller.rePasswordFocusNode,
                                  textInputAction: TextInputAction.next,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  name: 'rePassword',
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                      labelStyle: styleCompatibleX(context),
                                      border: InputBorder.none,
                                      labelText: AppTranslations.rePassword,
                                      prefixIcon: const Icon(Icons.password,
                                          color: Colors.grey),
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
                                  focusNode: controller.nameFocusNode,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  name: 'name',
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                    labelStyle: styleCompatibleX(context),
                                    border: InputBorder.none,
                                    labelText: AppTranslations.name,
                                    prefixIcon: const Icon(
                                      Icons.face,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
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
                                child: FormBuilderDateTimePicker(
                                  focusNode: controller.birthDayFocusNode,
                                  textInputAction: TextInputAction.next,
                                  // useRootNavigator: false,
                                  name: 'birthDay',
                                  initialEntryMode: DatePickerEntryMode.input,
                                  inputType: InputType.date,
                                  // inputFormatters: [
                                  //   MaskedInputFormatter('dd/mm/yyyy')
                                  // ],
                                  format: DateFormat("EEEE, d MMMM, yyyy"),
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                    labelStyle: styleCompatibleX(context),
                                    border: InputBorder.none,
                                    labelText: AppTranslations.birthDay,
                                    prefixIcon:
                                    const Icon(Icons.calendar_month),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  // locale: const Locale.fromSubtags(languageCode: 'fr'),
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
                                  focusNode: controller.phoneNumberFocusNode,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  name: 'phoneNumber',
                                  cursorColor: LocalizationService.to.appColor,
                                  decoration: InputDecoration(
                                    labelStyle: styleCompatibleX(context),

                                    /// Xóa dòng kẻ dưới: https://stackoverflow.com/a/49053291/10621168
                                    border: InputBorder.none,
                                    labelText: AppTranslations.phoneNumber,
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                              ),
                            ),
                            Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(marginSizeM),
                                child: GFBorder(
                                    radius: const Radius.circular(marginSizeM),
                                    color: LocalizationService.to.appColor,
                                    dashedLine: const [2, 0],
                                    type: GFBorderType.rRect,
                                    child: FormBuilderDropdown<RoleSelection>(
                                      initialValue: controller.roleOptions[0],
                                      name: 'role',
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      items: controller.roleOptions
                                          .map((value) => DropdownMenuItem(
                                        alignment:
                                        AlignmentDirectional.center,
                                        value: value,
                                        child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              children: [
                                                Icon(value.icon!,
                                                    color: Colors.grey),
                                                Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        10),
                                                    child: Text(
                                                      value.role!,
                                                      style: const TextStyle(
                                                          fontSize:
                                                          fontSizeS,
                                                          color: Colors
                                                              .grey),
                                                    )),
                                              ],
                                            )),
                                      ))
                                          .toList(),
                                    ))),
                            MediaQuery.of(context).viewInsets.bottom > 0
                                ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: marginSizeM,
                                  vertical: marginSizeM),
                              child: GFButton(
                                buttonBoxShadow: true,
                                size: GFSize.LARGE,
                                onPressed: controller.signUp,
                                text: AppTranslations.signUp,
                                textStyle: styleCompatibleX(context),
                                fullWidthButton: true,
                                color: LocalizationService.to.appColor,
                                type: GFButtonType.outline2x,
                              ),
                            )
                                : const SizedBox(),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                ],
              )),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Positioned(
            /// Dùng để nổi nút trên keyboard: https://stackoverflow.com/a/56932251/10621168
            // bottom: MediaQuery.of(context).viewInsets.bottom,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: colorCompatible(context),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: marginSizeM * 2, vertical: marginSizeM),
                  child: GFButton(
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                    onPressed: controller.signUp,
                    text: AppTranslations.signUp,
                    textStyle: styleCompatibleX(context),
                    fullWidthButton: true,
                    color: LocalizationService.to.appColor,
                    type: GFButtonType.outline2x,
                  )),
            ),
          )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
