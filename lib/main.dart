import 'dart:async';
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mighty_radio/store/AppStore.dart';
import 'package:mighty_radio/store/WishListStore/WishListStore.dart';
import 'package:mighty_radio/utils/Extensions/Commons.dart';
import 'package:mighty_radio/utils/Extensions/Constants.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/device_extensions.dart';
import 'package:mighty_radio/utils/Extensions/shared_pref.dart';
import 'package:mighty_radio/utils/colors.dart';
import 'package:mighty_radio/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppTheme.dart';
import 'model/DashboardResponse.dart';
import 'screen/SplashScreen.dart';

AppStore appStore = AppStore();
WishListStore wishListStore = WishListStore();
late SharedPreferences sharedPreferences;

Color defaultLoaderBgColorGlobal = Colors.white;
Color? defaultLoaderAccentColorGlobal = primaryColor1;

int passwordLengthGlobal = 6;
int mAdShowCount = 0;
int mAdCategoryShowCount = 0;
int mAdDetailShowCount = 0;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  String wishListString = getStringAsync(WISHLIST_ITEM_LIST);

  if (wishListString.isNotEmpty) {
    wishListStore.addAllWishListItem(jsonDecode(wishListString).map<Category>((e) => Category.fromJson(e)).toList());
  }

  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  if (isMobile) {
    await OneSignal.shared.setAppId(mOneSignalID);
    OneSignal.shared.consentGranted(true);
    OneSignal.shared.promptUserForPushNotificationPermission();
  }

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == ThemeModeLight) {
    appStore.setDarkMode(false);
  } else if (themeModeIndex == ThemeModeDark) {
    appStore.setDarkMode(true);
  }

  setStatusBarColorWidget(Colors.transparent,statusBarIconBrightness: Brightness.light);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((e) {
      wishListStore.setConnectionState(e);
      if (e == ConnectivityResult.none) {
        log('not connected');
      } else {
        connectivitySubscription.cancel();
        log('connected');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: AppName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        scrollBehavior: SBehavior(),
      );
    });
  }
}
