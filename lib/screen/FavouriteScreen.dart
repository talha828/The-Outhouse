import 'package:mighty_radio/component/ItemWidget.dart';
import 'package:mighty_radio/main.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:flutter/material.dart';
import 'package:mighty_radio/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../model/DashboardResponse.dart';
import 'AudioDetailScreen.dart';

class FavouriteScreen extends StatefulWidget {
  static String tag = '/FavouriteScreen';

  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  List<Category>? mList;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    mList = wishListStore.wishList;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(lbl_favourite),
      body: Observer(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wishListStore.wishList.isNotEmpty
                ? ListView.builder(
                    itemCount: wishListStore.wishList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 16,top: 8),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemWidget(wishListStore.wishList[index], isFavourite: true, onTap: () async {
                        AudioDetailScreen(data: wishListStore.wishList[index]).launch(context);
                      });
                    },
                  ).paddingBottom(appStore.playList.isNotEmpty ? 150 : 16).expand()
                : noDataWidget(context).expand(),
          ],
        );
      }),
    );
  }
}
