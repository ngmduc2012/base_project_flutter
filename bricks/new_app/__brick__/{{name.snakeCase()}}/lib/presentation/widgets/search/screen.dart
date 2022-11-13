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

class SearchScreen extends GetWidget<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    return GetBuilder<SearchController>(
      builder: (controller) => WillPopScope(
          onWillPop: () async {
            await controller.getBack();
            Get.back(result: controller.listResult);
            return true;
          },
          child: Form(
        // key: controller.formKey,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  color: LocalizationService.to.appColor,
                  onPressed: () async {
                    await controller.getBack();
                    Get.back(result: controller.listResult);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: iconSizeM,
                  ),
                ),
                shadowColor: AppColors.noColor,
                backgroundColor: AppColors.noColor,
                title: FormBuilder(
                    key: controller.formKey,
                    onChanged: () {
                      controller.formKey.currentState!.save();
                      debugPrint(
                          controller.formKey.currentState!.value.toString());
                      controller.search(
                          controller.formKey.currentState!.value['search']);
                    },
                    child: FormBuilderTextField(
                      focusNode: controller.searchFocusNode,
                      name: 'search',
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      // key: controller.emailFieldKey,
                      cursorColor: LocalizationService.to.appColor,
                      decoration: InputDecoration(
                        labelStyle: styleCompatibleX(context),
                        suffixIcon: IconButton(
                          onPressed: controller.searchBottom,
                          icon: Icon(
                            Icons.search_sharp,
                            color: LocalizationService.to.appColor,
                            size: iconSizeM,
                          ),
                        ),
                        label: Text(AppTranslations.search, style: styleCompatibleXL(context),),
                        border: InputBorder.none,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    )),
              ),
              body: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),

                  /// Bug: Vertical viewport was given unbounded height
                  /// The following: https://stackoverflow.com/a/54587532/10621168
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.listSearch.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GFRadioListTile(
                      title: Text(
                        controller.listSearch[index].title!,
                        style: styleCompatibleX(context),
                      ),
                      subTitle: Text(controller.listSearch[index].detail!,
                          style: styleCompatibleX(context)),
                      avatar: GFAvatar(
                        backgroundImage:
                            AssetImage(controller.listSearch[index].avatar!),
                      ),
                      size: iconSizeM,
                      activeBorderColor: LocalizationService.to.appColor,
                      focusColor: LocalizationService.to.appColor,
                      type: GFRadioType.basic,
                      value: controller.listSearch[index].id,
                      groupValue: controller.groupValue(controller.listSearch[index].id),
                      onChanged: (value) {
                        controller.onChangedMulti(value, controller.listSearch[index].id);
                      },
                      inactiveIcon: null,
                      radioColor: LocalizationService.to.appColor,
                      toggleable: true,
                      inactiveBorderColor: LocalizationService.to.appColor,
                      inactiveBgColor: colorCompatible(context),
                      activeBgColor: colorCompatible(context),
                    );
                  })),
        ),
      )),
    );
  }
}
