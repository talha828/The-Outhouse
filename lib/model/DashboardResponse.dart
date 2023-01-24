class DashboardResponse {
  Adsconfiguration? adsconfiguration;
  Appconfiguration? appconfiguration;
  OnesignalConfiguration? onesignalConfiguration;
  List<Category>? popularStation;
  List<Category>? latestStation;
  List<Category>? category;
  List<SliderResponse>? slider;

  DashboardResponse({this.adsconfiguration, this.appconfiguration, this.onesignalConfiguration, this.popularStation, this.category});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    adsconfiguration = json['adsconfiguration'] != null ? new Adsconfiguration.fromJson(json['adsconfiguration']) : null;
    appconfiguration = json['appconfiguration'] != null ? new Appconfiguration.fromJson(json['appconfiguration']) : null;
    onesignalConfiguration = json['onesignal_configuration'] != null ? new OnesignalConfiguration.fromJson(json['onesignal_configuration']) : null;
    if (json['popular_station'] != null) {
      popularStation = <Category>[];
      json['popular_station'].forEach((v) {
        popularStation!.add(new Category.fromJson(v));
      });
    }
    if (json['latest_station'] != null) {
      latestStation = <Category>[];
      json['latest_station'].forEach((v) {
        latestStation!.add(new Category.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['slider'] != null) {
      slider = <SliderResponse>[];
      json['slider'].forEach((v) {
        slider!.add(new SliderResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.adsconfiguration != null) {
      data['adsconfiguration'] = this.adsconfiguration!.toJson();
    }
    if (this.appconfiguration != null) {
      data['appconfiguration'] = this.appconfiguration!.toJson();
    }
    if (this.onesignalConfiguration != null) {
      data['onesignal_configuration'] = this.onesignalConfiguration!.toJson();
    }
    if (this.popularStation != null) {
      data['popular_station'] = this.popularStation!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.latestStation != null) {
      data['latest_station'] = this.latestStation!.map((v) => v.toJson()).toList();
    }
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Adsconfiguration {
  String? adsType;
  String? admobBannerId;
  String? admobInterstitialId;
  String? admobBannerIdIos;
  String? admobInterstitialIdIos;
  String? facebookBannerId;
  String? facebookInterstitialId;
  String? facebookBannerIdIos;
  String? facebookInterstitialIdIos;
  String? interstitialAdsInterval;
  String? bannerAdStationList;
  String? bannerAdCategoryList;
  String? bannerAdStationDetail;
  String? bannerAdStationSearch;
  String? interstitialAdStationList;
  String? interstitialAdCategoryList;
  String? interstitialAdStationDetail;

  Adsconfiguration(
      {this.adsType,
      this.admobBannerId,
      this.admobInterstitialId,
      this.admobBannerIdIos,
      this.admobInterstitialIdIos,
      this.facebookBannerId,
      this.facebookInterstitialId,
      this.facebookBannerIdIos,
      this.facebookInterstitialIdIos,
      this.interstitialAdsInterval,
      this.bannerAdStationList,
      this.bannerAdCategoryList,
      this.bannerAdStationDetail,
      this.bannerAdStationSearch,
      this.interstitialAdStationList,
      this.interstitialAdCategoryList,
      this.interstitialAdStationDetail});

  Adsconfiguration.fromJson(Map<String, dynamic> json) {
    adsType = json['ads_type'];
    admobBannerId = json['admob_banner_id'];
    admobInterstitialId = json['admob_interstitial_id'];
    admobBannerIdIos = json['admob_banner_id_ios'];
    admobInterstitialIdIos = json['admob_interstitial_id_ios'];
    facebookBannerId = json['facebook_banner_id'];
    facebookInterstitialId = json['facebook_interstitial_id'];
    facebookBannerIdIos = json['facebook_banner_id_ios'];
    facebookInterstitialIdIos = json['facebook_interstitial_id_ios'];
    interstitialAdsInterval = json['interstitial_ads_interval'];
    bannerAdStationList = json['banner_ad_station_list'];
    bannerAdCategoryList = json['banner_ad_category_list'];
    bannerAdStationDetail = json['banner_ad_station_detail'];
    bannerAdStationSearch = json['banner_ad_station_search'];
    interstitialAdStationList = json['interstitial_ad_station_list'];
    interstitialAdCategoryList = json['interstitial_ad_category_list'];
    interstitialAdStationDetail = json['interstitial_ad_station_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_type'] = this.adsType;
    data['admob_banner_id'] = this.admobBannerId;
    data['admob_interstitial_id'] = this.admobInterstitialId;
    data['admob_banner_id_ios'] = this.admobBannerIdIos;
    data['admob_interstitial_id_ios'] = this.admobInterstitialIdIos;
    data['facebook_banner_id'] = this.facebookBannerId;
    data['facebook_interstitial_id'] = this.facebookInterstitialId;
    data['facebook_banner_id_ios'] = this.facebookBannerIdIos;
    data['facebook_interstitial_id_ios'] = this.facebookInterstitialIdIos;
    data['interstitial_ads_interval'] = this.interstitialAdsInterval;
    data['banner_ad_station_list'] = this.bannerAdStationList;
    data['banner_ad_category_list'] = this.bannerAdCategoryList;
    data['banner_ad_station_detail'] = this.bannerAdStationDetail;
    data['banner_ad_station_search'] = this.bannerAdStationSearch;
    data['interstitial_ad_station_list'] = this.interstitialAdStationList;
    data['interstitial_ad_category_list'] = this.interstitialAdCategoryList;
    data['interstitial_ad_station_detail'] = this.interstitialAdStationDetail;
    return data;
  }
}

class Appconfiguration {
  String? facebook;
  String? instagram;
  String? twitter;
  String? whatsapp;
  String? privacyPolicy;
  String? termsCondition;
  String? contactUs;
  String? aboutUs;
  String? copyright;

  Appconfiguration({this.facebook, this.instagram, this.twitter, this.whatsapp, this.privacyPolicy, this.termsCondition, this.contactUs, this.aboutUs, this.copyright});

  Appconfiguration.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    privacyPolicy = json['privacy_policy'];
    termsCondition = json['terms_condition'];
    contactUs = json['contact_us'];
    aboutUs = json['about_us'];
    copyright = json['copyright'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['whatsapp'] = this.whatsapp;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_condition'] = this.termsCondition;
    data['contact_us'] = this.contactUs;
    data['about_us'] = this.aboutUs;
    data['copyright'] = this.copyright;
    return data;
  }
}

class OnesignalConfiguration {
  String? appId;
  String? restApiKey;

  OnesignalConfiguration({this.appId, this.restApiKey});

  OnesignalConfiguration.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    restApiKey = json['rest_api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    data['rest_api_key'] = this.restApiKey;
    return data;
  }
}

class PopularStation {
  String? id;
  String? name;
  String? categoryId;
  String? logo;
  String? url;
  String? isPopular;
  String? categoryName;

  PopularStation({this.id, this.name, this.categoryId, this.logo, this.url, this.isPopular, this.categoryName});

  PopularStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    logo = json['logo'];
    url = json['url'];
    isPopular = json['is_popular'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['logo'] = this.logo;
    data['url'] = this.url;
    data['is_popular'] = this.isPopular;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? logo;
  String? categoryId;
  String? url;
  String? isPopular;
  String? categoryName;
  List<Category>? station;

  Category({this.id, this.name, this.logo, this.station, this.categoryId, this.url, this.isPopular, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    if (json['station'] != null) {
      station = <Category>[];
      json['station'].forEach((v) {
        station!.add(new Category.fromJson(v));
      });
    }
    categoryId = json['category_id'];
    url = json['url'];
    isPopular = json['is_popular'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    if (this.station != null) {
      data['station'] = this.station!.map((v) => v.toJson()).toList();
    }
    data['category_id'] = this.categoryId;
    data['url'] = this.url;
    data['is_popular'] = this.isPopular;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Station {
  String? id;
  String? name;
  String? categoryId;
  String? logo;
  String? url;
  String? isPopular;

  Station({this.id, this.name, this.categoryId, this.logo, this.url, this.isPopular});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    logo = json['logo'];
    url = json['url'];
    isPopular = json['is_popular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['logo'] = this.logo;
    data['url'] = this.url;
    data['is_popular'] = this.isPopular;
    return data;
  }
}

class SliderResponse {
  String? id;
  String? title;
  String? url;
  String? image;
  String? status;
  String? imageUrl;

  SliderResponse({this.id, this.title, this.url, this.image, this.status, this.imageUrl});

  SliderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    status = json['status'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['image'] = this.image;
    data['status'] = this.status;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
