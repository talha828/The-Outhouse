import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mighty_radio/component/ItemWidget.dart';
import 'package:mighty_radio/network/RestApis.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:mighty_radio/utils/constant.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../main.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/decorations.dart';
import 'AudioDetailScreen.dart';
import '../component/BottomPanel.dart';
import 'PlayingScreen.dart';

class ViewAllScreen extends StatefulWidget {
  static String tag = '/ViewAllScreen';
  final int? categoryId;
  final bool? isLatest;
  final String? title;
  final bool? isCategory;
  final bool? isNew;

  ViewAllScreen({this.categoryId, this.title, this.isLatest = false, this.isCategory = false, this.isNew = false});

  @override
  ViewAllScreenState createState() => ViewAllScreenState();
}

class ViewAllScreenState extends State<ViewAllScreen> {
  PanelController? panelController;
  List<Category> mBookList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    getAPI();
    panelController = PanelController();

    FacebookAudienceNetwork.init(
      testingId: FACEBOOK_KEY,
      iOSAdvertiserTrackingEnabled: true,
    );
    if (widget.isCategory == true) {
      if (mCategoryViewAllInterstitialAds == '1') loadInterstitialAds();
    } else {
      if (mViewAllInterstitialAds == '1') loadInterstitialAds();
    }

  }

  @override
  void dispose() {
    if (widget.isCategory == true) {
      if (mCategoryViewAllInterstitialAds == '1') {
        if (mAdCategoryShowCount < int.parse(adsInterval)) {
          mAdCategoryShowCount++;
        } else {
          mAdCategoryShowCount = 0;
          showInterstitialAds();
        }
      }
    } else {
      if (mViewAllInterstitialAds == '1') {
        if (mAdShowCount < int.parse(adsInterval)) {
          mAdShowCount++;
        } else {
          mAdShowCount = 0;
          showInterstitialAds();
        }
      }
    }
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  getAPI() {
    appStore.setLoading(true);
    if (widget.isLatest == true) {
      getRadio(isLatest: widget.isLatest!).then((value) {
        loadData(value);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    } else if (widget.isNew == true) {
      getRadio(isNew: widget.isNew!).then((value) {
        loadData(value);
      }).catchError((e) {
        appStore.setLoading(false);

        toast(e.toString());
      });
    } else {
      getRadio(id: widget.categoryId!, isCategory: widget.isLatest!).then((value) {
        loadData(value);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    }
  }

  loadData(List<Category> value) {
    if (!mounted) return;
    setState(() {
      appStore.setLoading(false);
      mBookList.addAll(value);
    });
  }

  Widget mBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            children: List.generate(
              mBookList.length,
              (index) {
                Category data = mBookList[index];
                return AnimationConfiguration.staggeredGrid(
                  duration: Duration(milliseconds: 750),
                  columnCount: 1,
                  position: index,
                  child: ItemWidget(data, isGrid: true, onTap: () async {
                    AudioDetailScreen(data: data).launch(context);
                  }).paddingOnly(top: 16, left: 16),
                );
              },
            ),
          ),
        ),
        if (!appStore.isLoading && mBookList.isEmpty) noDataWidget(context).center(),
        mProgress().center().visible(appStore.isLoading),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: appBar(widget.title!, showBack: true),
        bottomNavigationBar: widget.isCategory == true
            ? mCategoryViewAllBannerAds == '1'
                ? showBannerAds()
                : SizedBox()
            : mViewAllBannerAds == '1'
                ? showBannerAds()
                : SizedBox(),
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
                  },
                ),
                body: mBody())
            : mBody(),
      );
    });
  }
}
