import 'package:flutter/material.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/appWidget.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import 'WebViewScreen.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(lbl_about_us,showBack: true),
      bottomNavigationBar: Container(
        height: 130,
        child: Column(
          children: [
            Text(lbl_follows_us, style: boldTextStyle()),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    var whatsappUrl = "whatsapp://send?phone=${getStringAsync(WHATSAPP)}";
                    launchUrl(Uri.parse(whatsappUrl));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_whatsApp, height: 35, width: 35),
                  ),
                ).visible(!getStringAsync(WHATSAPP).isEmptyOrNull),
                InkWell(
                  onTap: () {
                    if (getStringAsync(INSTAGRAM).isNotEmpty) {
                      WebViewScreen(mInitialUrl: getStringAsync(INSTAGRAM)).launch(context);
                    } else {
                      toast(lbl_url_empty);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_insta, height: 35, width: 35),
                  ),
                ).visible(!getStringAsync(INSTAGRAM).isEmptyOrNull),
                InkWell(
                  onTap: () {
                    if (getStringAsync(TWITTER).isNotEmpty) {
                      WebViewScreen(mInitialUrl: getStringAsync(TWITTER)).launch(context);
                    } else {
                      toast(lbl_url_empty);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_twitter, height: 35, width: 35),
                  ),
                ).visible(!getStringAsync(TWITTER).isEmptyOrNull),
                InkWell(
                  onTap: () {
                    if (getStringAsync(FACEBOOK).isNotEmpty) {
                      WebViewScreen(
                        mInitialUrl: getStringAsync(FACEBOOK),
                      ).launch(context);
                    } else {
                      toast(lbl_url_empty);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(ic_facebook, height: 35, width: 35),
                  ),
                ).visible(!getStringAsync(FACEBOOK).isEmptyOrNull),
                InkWell(
                  onTap: () {
                    if (getStringAsync(CONTACT_PREF).isNotEmpty) {
                      launchUrl(Uri.parse(('tel://${getStringAsync(CONTACT_PREF).validate()}')));
                    } else {
                      toast(lbl_url_empty);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.call, color: appStore.isDarkModeOn ? Colors.white : primaryColor1, size: 36),
                  ),
                ).visible(!getStringAsync(CONTACT_PREF).isEmptyOrNull)
              ],
            ),
            8.height,
            getStringAsync(COPYRIGHT).isNotEmpty
                ? Text(getStringAsync(COPYRIGHT), style: secondaryTextStyle(letterSpacing: 1.2), maxLines: 1)
                : Text("CopyRight" + " @${DateTime.now().year} meetmighty", style: secondaryTextStyle(letterSpacing: 1.2)),
            8.height,
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (_, snap) {
              if (snap.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(12),
                        decoration: boxDecorationRoundedWithShadowWidget(6, backgroundColor: Colors.white, blurRadius: 5),
                        child: Image.asset(ic_logo, width: 120, height: 120)),
                    Text('${snap.data!.appName.validate()}', style: boldTextStyle(size: 20)),
                    SizedBox(height: 6),
                    Text(getStringAsync(ABOUT_US_PREF), style: secondaryTextStyle(), textAlign: TextAlign.center).paddingOnly(left: 16, right: 16),
                  ],
                );
              }
              return SizedBox();
            }),
      ),
    );
  }
}
