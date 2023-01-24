import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/decorations.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:mighty_radio/utils/images.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import 'DashboardScreen.dart';
import 'GetStartedScreen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  init() async {
    await 2.seconds.delay;
    bool seen = (getBoolAsync('isFirstTime'));
    if (seen) {
      DashboardScreen().launch(context, isNewTask: true);
    } else {
      await setValue('isFirstTime', true);
      GetStartedScreen().launch(context, isNewTask: true);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Container(
        height: context.height(),
        decoration: boxDecorationWithShadowWidget(gradient: LinearGradient(colors: [primaryColor1, primaryColor2], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(top: 0.0, left: -15.0, right: -320.0, child: Image.asset(ic_splash)),
              ],
            ),
            Text(AppName, style: boldTextStyle(size: 30, color: Colors.white))
          ],
        ).center(),
      ),
    );
  }
}
