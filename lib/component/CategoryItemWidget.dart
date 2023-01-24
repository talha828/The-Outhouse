import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:flutter/material.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/text_styles.dart';

class CategoryItemWidget extends StatefulWidget {
  static String tag = '/CategoryItemWidget';
  final Category data;
  final Function? onTap;

  CategoryItemWidget(this.data, {this.onTap});

  @override
  CategoryItemWidgetState createState() => CategoryItemWidgetState();
}

class CategoryItemWidgetState extends State<CategoryItemWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double h = 150;
    double w = (context.width() - 50) / 2;

    return SizedBox(
      width: w,
      child: GestureDetector(
        onTap: () {
          widget.onTap!.call();
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.data.logo != null && widget.data.logo!.isNotEmpty) cachedImage(widget.data.logo, fit: BoxFit.cover, width: w, height: h).cornerRadiusWithClipRRect(12),
            8.height,
            Text(parseHtmlStringWidget(widget.data.name!.trim()), maxLines: 2, style: primaryTextStyle()).paddingSymmetric(horizontal: 4),
          ],
        ),
      ),
    );
  }
}
