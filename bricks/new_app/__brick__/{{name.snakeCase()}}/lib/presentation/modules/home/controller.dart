import 'package:{{name.snakeCase()}}/app/types/image_theme.dart';
import 'package:{{name.snakeCase()}}/data/modles/list_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:developer' as d;

import '../../../app/core/routes/routes.dart';
import '../../../app/services/local_storage_get.dart';
import '../../../app/services/localization.dart';
import '../../../app/types/key.dart';
import '../../../data/modles/color_select.dart';
import '../../../data/modles/user.dart';
import '../../widgets/search/screen.dart';

class HomeController extends FullLifeCycleController with GetSingleTickerProviderStateMixin {
  ///Call HomeController in other model
  static HomeController get to => Get.find();

  String updateErrorMessage = "";

  ///Initial Scroll for SingleChildScrollView, follow: https://stackoverflow.com/a/56220250/10621168
  final ScrollController scrollControllerHome = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  onReady() async {
    super.onReady();
    changeColor();
    changeTheme();

    /// Firebase ========================================

    ///notify permission for IOS and web
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    saveTokenFireBase();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // _handleMessage(message);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? ios = message.notification?.apple;
      // AndroidNotification? android = message.data["notification"]?.android;
      update();

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null && ios != null) {
        ///Bug flutter_local_notifications: "PlatformException (PlatformException(INVALID_ICON, The resource could not be found))
        ///After Fix bug, delete app and install again.
        ///The following: https://stackoverflow.com/a/55821110/10621168
        var initializationSettingsAndroid =
        AndroidInitializationSettings(android.smallIcon!);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                icon: initializationSettingsAndroid.defaultIcon,
                // other properties...
              ),
              iOS: const IOSNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              )),
        );
      }
    });

    /// =================================================
  }

  /// Firebase ========================================

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  saveTokenFireBase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token: $token");
  }

  /// =================================================
  var accessToken = "";


  /// TAB =============================================
  late TabController tabController;

  final LocalStorage _storage = LocalStorage.get;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    final json = _storage.read(USER_CONTROLLER);
    if (json != null) {
      user = User.fromJson(json);
      if (user != null) {
        accessToken = user.accessToken!;
        // print("accessToken: $accessToken");
        // isLoggedIn = true;
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<ListItem> listResult = [];

  search() async {
    listResult =
    await Get.to(const SearchScreen());
    update();
    // print("${controller.listResult.length}");
  }


  /// =======
  User user = User();


  logout(){
    user = User();
    _storage.remove(USER_CONTROLLER);
    _storage.remove(COLOR);
    _storage.remove(THEME);
    Get.offAndToNamed(Routes.WELCOME);
  }

  changeColor() async {
    final json = _storage.read(COLOR);
    if (json != null) {
      LocalizationService.to.colorApp(colorOptions[json].color!);
    }
    update();
  }

  List<ColorSelection> colorOptions = [
    ColorSelection(
      id: 0,
      color: GFColors.DANGER,
    ),
    ColorSelection(
      id: 1,
      color: GFColors.WARNING,
    ),
    ColorSelection(
      id: 2,
      color: GFColors.SUCCESS,
    ),
    ColorSelection(
      id: 3,
      color: GFColors.INFO,
    ),
    ColorSelection(
      id: 4,
      color: GFColors.PRIMARY,
    ),
    ColorSelection(
      id: 5,
      color: GFColors.SECONDARY,
    ),
    ColorSelection(
      id: 6,
      color: GFColors.ALT,
    ),
  ];


  changeTheme() async {
    final json = _storage.read(THEME);
    if (json != null) {
      LocalizationService.to.changeTheme(json);
    }
  }


}
