import 'package:mighty_radio/component/CategoryItemWidget.dart';
import 'package:mighty_radio/network/RestApis.dart';
import 'package:mighty_radio/screen/ViewAllScreen.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:mighty_radio/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../main.dart';
import '../model/DashboardResponse.dart';

class CategoryScreen extends StatefulWidget {
  static String tag = '/CategoryScreen';

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(lbl_category),
      body: FutureBuilder<List<Category>>(
        future: getCategories(),
        builder: (_, snap) {
          if (snap.hasData) {
            return snap.data!.isNotEmpty
                ? SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        snap.data!.length,
                        (index) {
                          Category data = snap.data![index];
                          return AnimationConfiguration.staggeredGrid(
                            duration: Duration(milliseconds: 750),
                            columnCount: 1,
                            position: index,
                            child: CategoryItemWidget(data, onTap: () {
                              ViewAllScreen(title: data.name, categoryId: data.id.toInt(), isCategory: true).launch(context);
                            }).paddingOnly(top: 16, left: 16),
                          );
                        },
                      ),
                    ).paddingBottom(appStore.playList.isNotEmpty ? 150 : 30),
                  )
                : noDataWidget(context);
          }
          return snapWidgetHelper(snap, loadingWidget: mProgress());
        },
      ),
    );
  }
}
