import 'package:flutter/material.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/Extensions/text_styles.dart';
import 'package:mighty_radio/utils/images.dart';
import '../model/WalkThroughModel.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import 'DashboardScreen.dart';

class GetStartedScreen extends StatefulWidget {
  static String tag = '/GetStartedScreen';

  @override
  GetStartedScreenState createState() => GetStartedScreenState();
}

class GetStartedScreenState extends State<GetStartedScreen> {
  int? currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  List<WalkThroughModel> walkThroughClass = [
    WalkThroughModel(
      text: lbl_walk1_desc,
      name: lbl_walk1,
      img: ic_walk1,
    ),
    WalkThroughModel(
      text: lbl_walk2_desc,
      name: lbl_walk2,
      img: ic_walk2,
    ),
    WalkThroughModel(
      text: lbl_walk3_desc,
      name: lbl_walk3,
      img: ic_walk3,
    )
  ];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: context.height(),
            child: PageView.builder(
              itemCount: walkThroughClass.length,
              controller: pageController,
              itemBuilder: (context, i) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(walkThroughClass[i].img.toString(), fit: BoxFit.fill, width: context.width()),
                    Container(
                      decoration: boxDecorationWithRoundedCornersWidget(
                          borderRadius: radius(0), gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryColor1.withOpacity(0.8), primaryColor2.withOpacity(0.8)])),
                    ),
                  ],
                );
              },
              onPageChanged: (int i) {
                currentIndex = i;
                setState(() {});
              },
            ),
          ),
          Positioned(
            top: context.statusBarHeight + 4,
            right: 2,
            left: 16,
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  DashboardScreen().launch(context);
                },
                child: Text(lbl_skip, style: boldTextStyle(color: Colors.white)),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(walkThroughClass[currentIndex!.toInt()].name.toString(), style: boldTextStyle(size: 28, color: Colors.white)),
                16.height,
                Text(walkThroughClass[currentIndex!.toInt()].text.toString(), style: secondaryTextStyle(size: 16, color: Colors.white70)),
                80.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dotIndicator(walkThroughClass, currentIndex, isPersonal: false).paddingTop(8),
                    GestureDetector(
                      onTap: () {
                        if (currentIndex!.toInt() >= 2) {
                          DashboardScreen().launch(context);
                        } else {
                          pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: boxDecorationWithRoundedCornersWidget(borderRadius: radius(), backgroundColor: Colors.white),
                        child: Text(currentIndex!.toInt() >= 2 ? lbl_get_started : lbl_next, style: primaryTextStyle(color: primaryColor1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
