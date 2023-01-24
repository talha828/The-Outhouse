import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mighty_radio/component/ItemWidget.dart';
import 'package:mighty_radio/component/NewReleaseItemWidget.dart';
import 'package:mighty_radio/model/DashboardResponse.dart';
import 'package:mighty_radio/network/RestApis.dart';
import 'package:mighty_radio/screen/ViewAllScreen.dart';
import 'package:mighty_radio/screen/WebViewScreen.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/decorations.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:mighty_radio/utils/colors.dart';
import 'package:mighty_radio/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../component/SliderWidget.dart';
import '../main.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import '../utils/constant.dart';
import 'AudioDetailScreen.dart';
import 'SearchScreen.dart';
import '../utils/appWidget.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  PanelController? panelController;

  @override
  void initState() {
    super.initState();
  }


  @override
  void setState(fn) {
    panelController = PanelController();
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String title, {int? id, bool? isLatest = false, bool? isNew = false, bool? isCategory = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: primaryTextStyle(size: 20, fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily)).expand(),
        Text('More', style: secondaryTextStyle(color: primaryColor1)).onTap(() {
          ViewAllScreen(categoryId: id, title: title, isCategory: isCategory, isNew: isNew, isLatest: isLatest).launch(context);
        }),
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppName, style: boldTextStyle(color: Colors.white, size: 20)),
        flexibleSpace: Container(
          decoration: boxDecorationWithShadowWidget(gradient: LinearGradient(colors: [primaryColor1, primaryColor2])),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Ionicons.search_sharp, color: Colors.white),
            onPressed: () {
              SearchScreen().launch(context);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await 2.seconds.delay;
          setState(() {});
        },
        child: FutureBuilder<DashboardResponse>(
          future: getDashboard(),
          builder: (_, snap) {
            if (snap.hasData) {
              return snap.data!.popularStation != null && snap.data!.popularStation!.isNotEmpty
                  ? SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (snap.data!.slider != null && snap.data!.slider!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                16.height,
                                HorizontalList(
                                  itemCount: snap.data!.slider!.length,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (BuildContext context, int i) {
                                    return SliderWidget(
                                      snap.data!.slider![i],
                                      onTap: () async {
                                        WebViewScreen(mInitialUrl: snap.data!.slider![i].url).launch(context);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          if (snap.data!.latestStation != null && snap.data!.latestStation!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.height,
                                mHeading(lbl_new_release, isLatest: true),
                                HorizontalList(
                                  itemCount: snap.data!.latestStation!.length,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  itemBuilder: (BuildContext context, int i) {
                                    return NewReleaseItemWidget(
                                      snap.data!.latestStation![i],
                                      onTap: () async {
                                        AudioDetailScreen(data: snap.data!.latestStation![i]).launch(context);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          if (snap.data!.popularStation != null && snap.data!.popularStation!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                4.height,
                                mHeading(lbl_popular_station, isNew: true),
                                Container(
                                  height: 430,
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snap.data!.popularStation!.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(left: 16),
                                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 230, childAspectRatio: 1.25),
                                    itemBuilder: (context, index) {
                                      Category data = snap.data!.popularStation![index];
                                      return ItemWidget(data, isPopular: true, onTap: () async {
                                        AudioDetailScreen(data: data).launch(context);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          if (snap.data!.category != null && snap.data!.category!.isNotEmpty)
                            ListView.builder(
                              itemCount: snap.data!.category!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 16),
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mHeading(snap.data!.category![index].name!, isCategory: true, id: snap.data!.category![index].id.toInt()),
                                    HorizontalList(
                                      itemCount: snap.data!.category![index].station!.length,
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      itemBuilder: (BuildContext context, int i) {
                                        return ItemWidget(
                                          snap.data!.category![index].station![i],
                                          onTap: () async {
                                            AudioDetailScreen(data: snap.data!.category![index].station![i]).launch(context);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ).paddingBottom(16).visible(snap.data!.category![index].station!.isNotEmpty);
                              },
                            ).paddingBottom(appStore.playList != null && appStore.playList.isNotEmpty ? 80 : 0),
                        ],
                      ),
                    )
                  : noDataWidget(context);
            }
            return snapWidgetHelper(snap, loadingWidget: mProgress());
          },
        ),
      ),
    );
  }
}
