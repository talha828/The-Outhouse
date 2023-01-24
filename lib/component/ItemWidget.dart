import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/utils/Extensions/Commons.dart';
import 'package:mighty_radio/utils/Extensions/Constants.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../model/DashboardResponse.dart';
import '../utils/Extensions/text_styles.dart';

class ItemWidget extends StatefulWidget {
  static String tag = '/ItemWidget';
  final Function? onTap;
  final bool? isFavourite;
  final bool? isGrid;
  final bool? isPopular;
  final Category data;

  ItemWidget(this.data, {this.onTap, this.isFavourite = false, this.isGrid = false, this.isPopular = false});

  @override
  ItemWidgetState createState() => ItemWidgetState();
}

class ItemWidgetState extends State<ItemWidget> {
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
    double w = widget.isGrid == true ? (context.width() - 44) / 2 : context.width() * 0.41;
    double h = widget.isGrid == true ? 150 : 158;
    return widget.isFavourite == false
        ? SizedBox(
            width: w,
            child: GestureDetector(
              onTap: () {
                widget.onTap!.call();
                setState(() {});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.data.logo != null && widget.data.logo!.isNotEmpty) cachedImage(widget.data.logo, fit: BoxFit.fill, width: w, height: h).cornerRadiusWithClipRRect(defaultRadius),
                  8.height,
                  Text(parseHtmlStringWidget(widget.data.name!.trim()), maxLines: 2, textAlign: TextAlign.center, style: primaryTextStyle()).paddingSymmetric(horizontal: 4),
                ],
              ).paddingRight(widget.isPopular == true ? 12 : 4),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.data.logo != null && widget.data.logo!.isNotEmpty) cachedImage(widget.data.logo, fit: BoxFit.fill, width: 50, height: 50).cornerRadiusWithClipRRect(defaultRadius),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(parseHtmlStringWidget(widget.data.name!.trim()), maxLines: 1, style: primaryTextStyle()),
                      Text(parseHtmlStringWidget(widget.data.categoryName!.trim()), maxLines: 1, style: secondaryTextStyle()),
                    ],
                  ),
                ],
              ),
              Icon(
                wishListStore.isItemInWishlist(widget.data.id!.toInt()) == false ? MaterialIcons.favorite_border : MaterialIcons.favorite,
                color: context.iconColor,
              ).onTap(() {
                Category mWishListModel = Category();
                mWishListModel = widget.data;
                wishListStore.addToWishList(mWishListModel);
                setState(() {});
              })
            ],
          ).paddingOnly(left: 16,right: 16,top: 8,bottom: 8).onTap(() {
            hideKeyboard(context);
            widget.onTap!.call();
            setState(() {});
          });
  }
}
