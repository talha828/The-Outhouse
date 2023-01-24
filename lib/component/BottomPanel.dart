import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mighty_radio/utils/Extensions/Constants.dart';
import 'package:mighty_radio/utils/Extensions/Widget_extensions.dart';
import 'package:mighty_radio/utils/Extensions/decorations.dart';
import 'package:mighty_radio/utils/Extensions/int_extensions.dart';
import 'package:mighty_radio/utils/Extensions/text_styles.dart';
import 'package:mighty_radio/utils/appWidget.dart';
import 'package:mighty_radio/utils/colors.dart';
import '../main.dart';
import 'AudioComponent.dart';

class BottomPanel extends StatefulWidget {
  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return appStore.playList.isNotEmpty ? mBottom() : Container();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  mBottom() {
    return assetsAudioPlayer.builderCurrent(builder: (BuildContext context, Playing playing) {
      final mAudio = find(audios, playing.audio.assetAudioPath);
      return Container(
        decoration: boxDecorationWithRoundedCornersWidget(
            borderRadius: radius(0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 0.5, 0.9],
              colors: [
                primaryColor1,
                primaryColor1.withOpacity(0.8),
                primaryColor2,
              ],
            )),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                8.width,
                cachedImage(mAudio.metas.image!.path, height: 50, width: 50, fit: BoxFit.fill).cornerRadiusWithClipRRect(defaultRadius),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      mAudio.metas.title!,
                      overflow: TextOverflow.ellipsis,
                      style: primaryTextStyle(color: Colors.white),
                    ),
                    Text(
                      mAudio.metas.artist!,
                      style: secondaryTextStyle(size: 12, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ).flexible(),
              ],
            ).expand(),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      wishListStore.addToWishList(appStore.playList[0]);
                      setState(() {});
                    },
                    iconSize: 28,
                    icon: Icon(
                      wishListStore.isItemInWishlist(int.parse(mAudio.metas.id.toString())) == false ? MaterialIcons.favorite_border : MaterialIcons.favorite,
                      color: Colors.white,
                    )),
                assetsAudioPlayer.builderLoopMode(
                  builder: (context, loopMode) {
                    return PlayerBuilder.isPlaying(
                        player: assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          return Align(
                              alignment: Alignment.center,
                              child: PlayerBuilder.isBuffering(
                                  player: assetsAudioPlayer,
                                  builder: (context, isBuffering) {
                                    return isBuffering
                                        ? Container(
                                            decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [primaryColor1, primaryColor2])),
                                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2).paddingAll(6),
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              assetsAudioPlayer.playOrPause();
                                            },
                                            iconSize: 35,
                                            icon: Icon(
                                              isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                                              color: Colors.white,
                                            ),
                                          );
                                  }));
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
