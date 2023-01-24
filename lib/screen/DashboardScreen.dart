import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/main.dart';
import 'package:mighty_radio/screen/CategoryScreen.dart';
import 'package:mighty_radio/screen/FavouriteScreen.dart';
import 'package:mighty_radio/screen/HomeScreen.dart';
import 'package:mighty_radio/screen/SettingScreen.dart';
import 'package:mighty_radio/screen/WebViewScreen.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import 'package:mighty_radio/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:mighty_radio/utils/strings.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import '../component/BottomPanel.dart';
import 'PlayingScreen.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  PanelController? panelController;

  final tab = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    init();
    panelController = PanelController();
  }

  init() async {
    //
    if (isMobile) {
      OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult notification) async {
        if (!notification.notification.launchUrl.isEmptyOrNull) {
          WebViewScreen(mInitialUrl: notification.notification.launchUrl).launch(context);
        }
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mActiveIcon(var icon) {
    return Container(
        height: 35,
        width: 35,
        alignment: Alignment.center,
        padding: EdgeInsets.all(6),
        decoration: boxDecorationWithRoundedCornersWidget(borderRadius: radius(), gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryColor1, primaryColor2])),
        child: Icon(icon, color: Colors.white, size: 18));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        body: appStore.playList.isNotEmpty
            ? SlidingUpPanel(
                borderRadius: radius(),
                panel: PlayingScreen(),
                minHeight: 60,
                controller: panelController,
                maxHeight: MediaQuery.of(context).size.height,
                backdropEnabled: true,
                backdropOpacity: 0.5,
                parallaxEnabled: true,
                collapsed: GestureDetector(
                    child: BottomPanel(),
                    onTap: () {
                      panelController!.open();
                    }),
                body: tab[_currentIndex])
            : tab[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: primaryTextStyle(),
          currentIndex: _currentIndex,
          unselectedItemColor: unSelectIconColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor1,
          onTap: (index) {
            _currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Ionicons.ios_home_outline), activeIcon: mActiveIcon(Ionicons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.view_dashboard_outline), activeIcon: mActiveIcon(MaterialCommunityIcons.view_dashboard), label: ''),
            BottomNavigationBarItem(icon: Icon(MaterialIcons.favorite_border), activeIcon: mActiveIcon(MaterialIcons.favorite), label: lbl_favourite),
            BottomNavigationBarItem(icon: Icon(Feather.settings), activeIcon: mActiveIcon(MaterialIcons.settings), label: lbl_setting),
          ],
        ),
      );
    });
  }
}
