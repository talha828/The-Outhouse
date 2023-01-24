import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/model/DashboardResponse.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/Extensions/shared_pref.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import '../main.dart';
import '../component/AudioComponent.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/appWidget.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/strings.dart';

class AudioDetailScreen extends StatefulWidget {
  final Category? data;

  AudioDetailScreen({this.data});

  @override
  _AudioDetailScreenState createState() => _AudioDetailScreenState();
}

class _AudioDetailScreenState extends State<AudioDetailScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    FacebookAudienceNetwork.init(
      testingId: FACEBOOK_KEY,
      iOSAdvertiserTrackingEnabled: true,
    );
    if (mDetailInterstitialAds == '1') loadInterstitialAds();
  }

  @override
  void dispose() {
    if (mDetailInterstitialAds == '1') {
      if (mAdDetailShowCount < int.parse(adsInterval)) {
        mAdDetailShowCount++;
      } else {
        mAdDetailShowCount = 0;
        showInterstitialAds();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: context.height(),
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.data!.logo.toString()), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90.0, sigmaY: 90.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.white))
                .paddingTop(context.statusBarHeight + 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cachedImage(widget.data!.logo.toString(), fit: BoxFit.fill, width: context.width(), height: context.height() * 0.42).cornerRadiusWithClipRRect(26).paddingOnly(left: 30, right: 30, top: 16, bottom: 16),
                Text(widget.data!.name!.validate(), style: boldTextStyle(size: 22, color: Colors.white)),
                8.height,
                Text(widget.data!.categoryName.toString(), style: secondaryTextStyle(color: Colors.white70)),
                50.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          PackageInfo.fromPlatform().then((value) {
                            Share.share('$lbl_share_radio\n${widget.data!.url}');
                          });
                        },
                        iconSize: 30,
                        icon: Icon(Ionicons.share_social, color: Colors.white)),
                    16.width,
                    PlayerBuilder.isPlaying(
                        player: assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          return PlayerBuilder.isBuffering(
                              player: assetsAudioPlayer,
                              builder: (context, isBuffering) {
                                return isBuffering
                                    ? Container(
                                        decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [primaryColor1, primaryColor2])),
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2).paddingAll(6),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [primaryColor1, primaryColor2])),
                                        child: IconButton(
                                          onPressed: () async {
                                            hideKeyboard(context);
                                            if (assetsAudioPlayer.isPlaying.value == true) {
                                              if (getStringAsync(TEST) != widget.data!.id) {
                                                appStore.clearPlayList();
                                                appStore.addPlayListItem(widget.data!);
                                                audios.clear();
                                                await mRadio(ind: index, start: true, context: context, choiceIndex: 1);
                                              } else {
                                                assetsAudioPlayer.playOrPause();
                                              }
                                            } else {
                                              appStore.clearPlayList();
                                              appStore.addPlayListItem(widget.data!);
                                              audios.clear();
                                              await mRadio(ind: index, start: true, context: context, choiceIndex: 1);
                                            }
                                            appStore.setPlay(assetsAudioPlayer.isPlaying.value);
                                            setValue(TEST, widget.data!.id);
                                            setState(() {});
                                          },
                                          iconSize: 35,
                                          icon: Icon(
                                            isPlaying == true
                                                ? getStringAsync(TEST) != widget.data!.id
                                                    ? Icons.play_arrow
                                                    : Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                              });
                        }),
                    16.width,
                    IconButton(
                        onPressed: () {
                          Category mWishListModel = Category();
                          mWishListModel = widget.data!;
                          wishListStore.addToWishList(mWishListModel);
                          setState(() {});
                        },
                        iconSize: 30,
                        icon: Icon(wishListStore.isItemInWishlist(widget.data!.id.toInt()) == false ? MaterialIcons.favorite_border : MaterialIcons.favorite, color: Colors.white)),
                  ],
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: mDetailBannerAds == '1' ? showBannerAds() : SizedBox());
  }
}
