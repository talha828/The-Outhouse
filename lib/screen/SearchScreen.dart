import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/component/ItemWidget.dart';
import 'package:mighty_radio/model/DashboardResponse.dart';
import 'package:mighty_radio/network/RestApis.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../main.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/constant.dart';
import '../utils/strings.dart';
import 'AudioDetailScreen.dart';
import '../component/BottomPanel.dart';
import 'PlayingScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchCont = TextEditingController();

  List<Category> radioList = [];
  List<Category> searchList = [];

  PanelController? panelController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    panelController = PanelController();
    loadStation();
  }

  void loadStation() {
    appStore.setLoading(true);
    getRadio().then((value) {
      appStore.setLoading(false);
      setState(() {
        radioList.clear();
        radioList.addAll(value);
        searchList = radioList;
      });
    }).catchError((e) {
      appStore.setLoading(false);
      log(e);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget sliding() {
    return appStore.playList.isNotEmpty
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
        : mBody();
  }

  Widget mBody() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              autoFocus: true,
              textFieldType: TextFieldType.OTHER,
              decoration: inputDecoration(context, label: lbl_search_station, prefixIcon: Icon(Ionicons.search_outline)),
              controller: searchCont,
              onChanged: (v) async {
                setState(() {
                  searchList = radioList.where((u) => (u.name!.toLowerCase().contains(v.toLowerCase()) || u.name!.toLowerCase().contains(v.toLowerCase()))).toList();
                });
              },
              onFieldSubmitted: (c) {
                loadStation();
                setState(() {});
              },
            ).paddingAll(16),
            searchList.isEmpty && !appStore.isLoading
                ? noDataWidget(context).center()
                : ListView.builder(
                    itemCount: searchList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 16),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemWidget(searchList[index], isFavourite: true, onTap: () async {
                        AudioDetailScreen(data: searchList[index]).launch(context);
                      });
                    },
                  ).expand()
          ],
        ),
        mProgress().center().visible(appStore.isLoading)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(lbl_search_Station, showBack: true),
      body: Observer(builder: (context) {
        return sliding();
      }),
      bottomNavigationBar: mSearchBannerAds == '1' ? showBannerAds() : SizedBox(),
    );
  }
}
