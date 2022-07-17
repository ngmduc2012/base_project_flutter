import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/text_style.dart';
import '../../../routes/routes.dart';
import '../../widgets/menu_drawer.dart';
import 'controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: ListTile(
                    title: const Text(
                      "ngmduc2012",
                      style: styleTitle,
                      textAlign: TextAlign.center,
                    ),

                    ///Create number on icon notification,the following: https://stackoverflow.com/a/63968272/10621168
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(),
                      ],
                    )),
                flexibleSpace: const Image(
                  image: AssetImage("assets/images/bg_appbar.png"),
                  fit: BoxFit.cover,
                ),
              ),
              drawer: MenuDrawer(),
              body: RefreshIndicator(
                onRefresh: _pullRefresh,
                child:
                    // SingleChildScrollView(
                    //   // controller: controller.scrollControllerHome,
                    //   // physics: BouncingScrollPhysics(
                    //   //     parent: AlwaysScrollableScrollPhysics()),
                    //   child:
                    Padding(
                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                  child: ListView(
                    controller: controller.scrollControllerHome,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),

                    /// Bug: Vertical viewport was given unbounded height
                    /// The following: https://stackoverflow.com/a/54587532/10621168
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      /// information of user
                      SizedBox(height: context.height * 0.01),
                    ],
                  ),
                ),
                // ),
              ),
            ));
  }

  Future<void> _pullRefresh() async {}
}
