import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/main.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/context_extensions.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/Extensions/text_styles.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:mighty_radio/utils/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import '../component/AudioComponent.dart';
import '../utils/strings.dart';

class PlayingScreen extends StatefulWidget {
  static String tag = '/PlayingScreen';

  @override
  PlayingScreenState createState() => PlayingScreenState();
}

class PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: appStore.playList.isEmpty ? Container() : mBody());
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  mBody() {
    return assetsAudioPlayer.builderCurrent(builder: (BuildContext context, Playing playing) {
      final mAudio = find(audios, playing.audio.assetAudioPath);
      return Container(
          height: context.height(),
          width: context.width(),
          child: Stack(
            children: [
              Container(
                height: context.height(),
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(mAudio.metas.image!.path), fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 90.0, sigmaY: 90.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  cachedImage(mAudio.metas.image!.path, fit: BoxFit.fill, width: 300, height: 300).cornerRadiusWithClipRRect(12),
                  20.height,
                  Text(mAudio.metas.title!, textAlign: TextAlign.center, style: boldTextStyle(color: Colors.white, size: 20)),
                  10.height,
                  Text(
                    mAudio.metas.artist!,
                    style: secondaryTextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  30.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            PackageInfo.fromPlatform().then((value) {
                              Share.share('$lbl_share_radio\n${appStore.playList[0].url}');
                            });
                          },
                          iconSize: 30,
                          icon: Icon(Ionicons.share_social, color: Colors.white)),
                      16.width,
                      PlayerBuilder.isPlaying(
                          player: assetsAudioPlayer,
                          builder: (context, isPlaying) {
                            return Container(
                                padding: EdgeInsets.only(top: 7),
                                alignment: Alignment.topCenter,
                                child: PlayerBuilder.isBuffering(
                                    player: assetsAudioPlayer,
                                    builder: (context, isBuffering) {
                                      return isBuffering
                                          ? Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [primaryColor1, primaryColor2])),
                                              child: IconButton(
                                                onPressed: () async {
                                                  assetsAudioPlayer.playOrPause();
                                                },
                                                iconSize: 35,
                                                icon: Icon(
                                                  isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                    }));
                          }),
                      16.width,
                      IconButton(
                          onPressed: () {
                            wishListStore.addToWishList(appStore.playList[0]);
                            setState(() {});
                          },
                          iconSize: 30,
                          icon: Icon(
                            wishListStore.isItemInWishlist(int.parse(mAudio.metas.id.toString())) == false ? MaterialIcons.favorite_border : MaterialIcons.favorite,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ],
          ));
    });
  }
}
