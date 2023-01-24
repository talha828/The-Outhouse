import 'package:mighty_radio/model/DashboardResponse.dart';
import 'package:mighty_radio/network/NetworkUtils.dart';
import 'package:mighty_radio/utils/constant.dart';
import 'package:mighty_radio/utils/Extensions/string_extensions.dart';

import '../utils/Extensions/shared_pref.dart';

Future<List<Category>> getCategories() async {
  Iterable it = await (handleResponse(await buildHttpResponse('category.php')));
  return it.map((e) => Category.fromJson(e)).toList();
}

//
Future<DashboardResponse> getDashboard() async {
  return await handleResponse(await buildHttpResponse('dashboard.php')).then((value) async {
    var res = DashboardResponse.fromJson(value);

    if (res.appconfiguration != null) {
      await setValue(TERMS_AND_CONDITION_PREF, res.appconfiguration!.termsCondition.validate());
      await setValue(PRIVACY_POLICY_PREF, res.appconfiguration!.privacyPolicy.validate());
      await setValue(CONTACT_PREF, res.appconfiguration!.contactUs.validate());
      await setValue(ABOUT_US_PREF, res.appconfiguration!.aboutUs.validate());
      await setValue(FACEBOOK, res.appconfiguration!.facebook.validate());
      await setValue(WHATSAPP, res.appconfiguration!.whatsapp.validate());
      await setValue(TWITTER, res.appconfiguration!.twitter.validate());
      await setValue(INSTAGRAM, res.appconfiguration!.instagram.validate());
      await setValue(COPYRIGHT, res.appconfiguration!.copyright.validate());
    }
    if (res.adsconfiguration != null) {
      //ad
      await setValue(ADD_TYPE, res.adsconfiguration!.adsType);
      await setValue(FACEBOOK_BANNER_PLACEMENT_ID, res.adsconfiguration!.facebookBannerId.validate());
      await setValue(FACEBOOK_INTERSTITIAL_PLACEMENT_ID, res.adsconfiguration!.facebookInterstitialId.validate());
      await setValue(FACEBOOK_BANNER_PLACEMENT_ID_IOS, res.adsconfiguration!.facebookBannerIdIos.validate());
      await setValue(FACEBOOK_INTERSTITIAL_PLACEMENT_ID_IOS, res.adsconfiguration!.facebookInterstitialIdIos.validate());

      await setValue(ADMOB_BANNER_ID, res.adsconfiguration!.admobBannerId.validate());
      await setValue(ADMOB_INTERSTITIAL_ID, res.adsconfiguration!.admobInterstitialId.validate());
      await setValue(ADMOB_BANNER_ID_IOS, res.adsconfiguration!.admobBannerIdIos.validate());
      await setValue(ADMOB_INTERSTITIAL_ID_IOS, res.adsconfiguration!.facebookInterstitialIdIos.validate());

      await setValue(INTERSTITIAL_ADS_INTERVAL, res.adsconfiguration!.interstitialAdsInterval.validate());
      await setValue(BANNER_AD_RADIO_LIST, res.adsconfiguration!.bannerAdStationList.validate());
      await setValue(BANNER_AD_CATEGORY_LIST, res.adsconfiguration!.bannerAdCategoryList.validate());
      await setValue(BANNER_AD_RADIO_DETAIL, res.adsconfiguration!.bannerAdStationDetail.validate());
      await setValue(BANNER_AD_RADIO_SEARCH, res.adsconfiguration!.bannerAdStationSearch.validate());
      await setValue(INTERSTITIAL_AD_RADIO_LIST, res.adsconfiguration!.interstitialAdStationList.validate());
      await setValue(INTERSTITIAL_AD_CATEGORY_LIST, res.adsconfiguration!.interstitialAdCategoryList.validate());
      await setValue(INTERSTITIAL_AD_RADIO_DETAIL, res.adsconfiguration!.interstitialAdStationDetail.validate());
    }
    return res;
  });
}

Future<List<Category>> getRadio({int? id, bool isLatest = false,bool isCategory = false, bool isNew = false}) async {
  if (isLatest == true) {
    Iterable it = await (handleResponse(await buildHttpResponse('station.php?order_by=id&order=desc')));
    return it.map((e) => Category.fromJson(e)).toList();
  }  if (isNew == true) {
    Iterable it = await (handleResponse(await buildHttpResponse('station.php?is_popular=1')));
    return it.map((e) => Category.fromJson(e)).toList();
  } else if (id != null) {
    Iterable it = await (handleResponse(await buildHttpResponse('station.php?category_id=$id')));
    return it.map((e) => Category.fromJson(e)).toList();
  } else {
    Iterable it = await (handleResponse(await buildHttpResponse('station.php')));
    return it.map((e) => Category.fromJson(e)).toList();
  }
}
