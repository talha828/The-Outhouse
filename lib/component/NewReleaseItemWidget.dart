import 'package:mighty_radio/utils/Extensions/Commons.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/text_styles.dart';

class NewReleaseItemWidget extends StatefulWidget {
  static String tag = '/NewReleaseItemWidget.dart';
  final Function? onTap;
  final bool? isFavourite;
  final bool? isGrid;
  final Category data;

  NewReleaseItemWidget(this.data, {this.onTap, this.isFavourite = false, this.isGrid = false});

  @override
  NewReleaseItemWidgetState createState() => NewReleaseItemWidgetState();
}

class NewReleaseItemWidgetState extends State<NewReleaseItemWidget> {
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
    double w = context.width() * 0.27;
    return SizedBox(
      width: w,
      child: GestureDetector(
        onTap: () {
          widget.onTap!.call();
          setState(() {});
        },
        child: Column(
          children: [
            if (widget.data.logo != null && widget.data.logo!.isNotEmpty) CircleAvatar(backgroundImage: NetworkImage(widget.data.logo!), radius: 55, backgroundColor: context.cardColor),
            6.height,
            Text(parseHtmlStringWidget(widget.data.name!.trim()), textAlign: TextAlign.center, style: primaryTextStyle()).paddingSymmetric(horizontal: 4),
          ],
        ),
      ),
    );
  }
}
