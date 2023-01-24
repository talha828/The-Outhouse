import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:mighty_radio/utils/colors.dart';
import 'package:mighty_radio/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/SettingItemWidget.dart';
import '../component/ThemeSelectionDialog.dart';
import '../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/strings.dart';
import 'AboutUsScreen.dart';
import 'WebViewScreen.dart';

class SettingScreen extends StatefulWidget {
  static String tag = '/SettingScreen';

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget mLeadingIcon(var icon) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(6),
        decoration: boxDecorationWithShadowWidget(borderRadius: radius(), gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryColor1, primaryColor2])),
        child: Icon(icon, color: Colors.white, size: 18));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(lbl_setting.validate()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            SettingItemWidget(
              title: lbl_select_theme,
              leading: mLeadingIcon(Ionicons.ios_moon),
              onTap: () async {
                hideKeyboard(context);
                showDialog(
                  context: context,
                  builder: (_) => ThemeSelectionDialog(),
                );
              },
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: lbl_push_notification,
              leading: mLeadingIcon(Ionicons.notifications),
              onTap: () async {},
              trailing: Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  activeColor: primaryColor1,
                  value: appStore.isNotificationOn,
                  onChanged: (v) {
                    appStore.setNotification(v);
                    setState(() {});
                  },
                ).withHeight(10),
              ),
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: lbl_share + AppName,
              leading: mLeadingIcon(MaterialIcons.share),
              onTap: () {
                PackageInfo.fromPlatform().then((value) {
                  Share.share('Share $AppName app\n$playStoreBaseURL${value.packageName}');
                });
              },
            ),
            Divider(height: 1),
            SettingItemWidget(
              title: lbl_rate_us,
              leading: mLeadingIcon(MaterialIcons.star),
              onTap: () {
                PackageInfo.fromPlatform().then((value) {
                  String package = '';
                  if (isAndroid) package = value.packageName;
                  launchUrl(Uri.parse('${storeBaseURL()}$package'));
                });
              },
            ),
            Divider(height: 1).visible(getStringAsync(PRIVACY_POLICY_PREF).isNotEmpty),
            SettingItemWidget(
              title: lbl_privacy_policy,
              leading: mLeadingIcon(MaterialCommunityIcons.file_document_edit),
              onTap: () {
                if (getStringAsync(PRIVACY_POLICY_PREF).isNotEmpty)
                  WebViewScreen(
                    mInitialUrl: getStringAsync(PRIVACY_POLICY_PREF),
                  ).launch(context);
                else
                  toast(lbl_url_empty);
              },
            ).visible(!getStringAsync(PRIVACY_POLICY_PREF).isEmptyOrNull),
            Divider(height: 1).visible(getStringAsync(TERMS_AND_CONDITION_PREF).isNotEmpty),
            SettingItemWidget(
              title: lbl_terms_condition,
              leading: mLeadingIcon(MaterialCommunityIcons.shield_check),
              onTap: () async {
                if (getStringAsync(TERMS_AND_CONDITION_PREF).isNotEmpty)
                  WebViewScreen(mInitialUrl: getStringAsync(TERMS_AND_CONDITION_PREF)).launch(context);
                else
                  toast(lbl_url_empty);
              },
            ).visible(!getStringAsync(TERMS_AND_CONDITION_PREF).isEmptyOrNull),
            Divider(height: 1),
            SettingItemWidget(
              title: lbl_about_us,
              leading: mLeadingIcon(MaterialIcons.info),
              onTap: () {
                hideKeyboard(context);
                AboutUsScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
              },
            ),
          ],
        ),
      ),
    );
  }
}
