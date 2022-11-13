import 'package:{{name.snakeCase()}}/app/core/values/languages/translations.dart';
import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:{{name.snakeCase()}}/app/types/size.dart';
import 'package:{{name.snakeCase()}}/data/modles/list_item.dart';
import 'package:{{name.snakeCase()}}/presentation/widgets/menu_drawer.dart';
import 'package:{{name.snakeCase()}}/presentation/widgets/search/screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../app/core/routes/routes.dart';
import '../../../app/services/localization.dart';
import '../../../app/types/image_theme.dart';
import '../../../app/types/text_style.dart';
import 'controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
          bottomNavigationBar: GFTabBar(
            tabBarColor: AppColors.noColor,
            tabBarHeight: iconSizeM * 2,
            length: 2,
            controller: controller.tabController,
            indicatorColor: LocalizationService.to.appColor,
            indicatorWeight: 0.01,
            unselectedLabelColor: AppColors.light,
            labelColor: LocalizationService.to.appColor,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: iconSizeM,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  size: iconSizeM,
                ),
              ),
            ],
          ),
          appBar: AppBar(
            leading: Builder(
                builder: (context) => IconButton(
                  color: LocalizationService.to.appColor,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.now_widgets,
                    size: iconSizeM,
                  ),
                )),
            shadowColor: AppColors.noColor,
            backgroundColor: AppColors.noColor,
            actions: [
              GFAvatar(
                  radius: iconSizeS,
                  backgroundColor: LocalizationService.to.appColor,
                  child: IconButton(
                    onPressed: controller.search,
                    icon: const Icon(
                      Icons.search_sharp,
                      color: AppColors.white,
                      size: iconSizeS,
                    ),
                  )),
              const SizedBox(
                width: iconSizeS,
              ),
              GFIconBadge(
                position:
                GFBadgePosition.topStart(top: 0, start: -marginSizeM),
                padding: const EdgeInsets.only(right: iconSizeS),
                counterChild: const GFBadge(
                  child: Text("3"),
                ),
                child: GFAvatar(
                    radius: iconSizeS,
                    backgroundColor: LocalizationService.to.appColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        color: AppColors.white,
                        size: iconSizeS,
                      ),
                    )),
              ),
            ],
          ),
          drawer: const MenuDrawer(),
          body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child:
            // SingleChildScrollView(
            //   // controller: controller.scrollControllerHome,
            //   // physics: BouncingScrollPhysics(
            //   //     parent: AlwaysScrollableScrollPhysics()),
            //   child:

            GFTabBarView(
                controller: controller.tabController,
                children: <Widget>[
                  controller.listResult.isEmpty ? Center(
                    child: GFImageOverlay(
                      height: context.width*0.4,
                      width: context.width*0.3,
                      image: const AssetImage(logoImage),
                      colorFilter:  const ColorFilter.mode(AppColors.noColor,
                          BlendMode.color),
                    ),
                  ) :  ListView.builder(
                      controller: controller.scrollControllerHome,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),

                      /// Bug: Vertical viewport was given unbounded height
                      /// The following: https://stackoverflow.com/a/54587532/10621168
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.listResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GFListTile(
                          title: Text(
                            controller.listResult[index].title!,
                            style: styleCompatibleX(context),
                          ),
                          subTitle: Text(
                              controller.listResult[index].detail!,
                              style: styleCompatibleX(context)),
                          avatar: GFAvatar(
                            backgroundImage: AssetImage(
                                controller.listResult[index].avatar!),
                          ),
                          focusColor: LocalizationService.to.appColor,
                        );
                      }),
                  ListView(
                    padding: const EdgeInsets.all(marginSizeM * 2),
                    controller: controller.scrollControllerHome,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),

                    /// Bug: Vertical viewport was given unbounded height
                    /// The following: https://stackoverflow.com/a/54587532/10621168
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: context.height * 0.06,
                        child: GFListTile(
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.all(0),
                          icon: GFAvatar(
                              radius: iconSizeS,
                              backgroundColor:
                              LocalizationService.to.appColor,
                              child: IconButton(
                                onPressed: () {
                                  Get.toNamed(Routes.EDIT);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.white,
                                  size: iconSizeS,
                                ),
                              )),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          left: context.width * 0.2,
                          right: context.width * 0.2,
                        ),
                        child: GFAvatar(
                            maxRadius: context.width * 0.3,
                            minRadius: context.width * 0.3,
                            // shape: GFAvatarShape.standard,
                            size: GFSize.SMALL,
                            // radius: radiusSizeM,
                            backgroundImage: controller.user.avatar != null ? Image.memory(
                              controller.user.avatar!,
                            ).image : null),
                      ),
                      SizedBox(
                        height: context.height * 0.03,
                      ),
                      Center(
                        child: Text(
                          controller.user.name ?? "",
                          style: styleCompatibleXL(context),
                        ),
                      ),
                      Center(
                        child: Text(
                          controller.user.email ?? "",
                          style: styleCompatibleX(context),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.27,
                      ),
                      // GFButton(
                      //   textStyle: styleX,
                      //   color: AppColors.appColor,
                      //   fullWidthButton: true,
                      //   onPressed: () {
                      //     Get.toNamed(Routes.EDIT);
                      //   },
                      //   text: "Chỉnh sửa hồ sơ",
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     color: AppColors.light,
                      //   ),
                      //   // type: GFButtonType.outline2x,
                      // ),
                      GFButton(
                        textStyle: styleCompatibleX(context),
                        color: LocalizationService.to.appColor,
                        fullWidthButton: true,
                        onPressed: () {},
                        text: AppTranslations.changePass,
                        icon: Icon(Icons.lock_reset,
                            size: iconSizeM,
                            color: LocalizationService.to.appColor),
                        // type: GFButtonType.outline2x,
                        type: GFButtonType.transparent,
                      ),
                    ],
                  ),
                ]),

            // ),
          ),
        ));
  }

  Future<void> _pullRefresh() async {}
}
