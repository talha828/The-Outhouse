// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$isDarkModeOnAtom = Atom(name: '_AppStore.isDarkModeOn');

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  final _$isNotificationOnAtom = Atom(name: '_AppStore.isNotificationOn');

  @override
  bool get isNotificationOn {
    _$isNotificationOnAtom.reportRead();
    return super.isNotificationOn;
  }

  @override
  set isNotificationOn(bool value) {
    _$isNotificationOnAtom.reportWrite(value, super.isNotificationOn, () {
      super.isNotificationOn = value;
    });
  }

  final _$isPlayAtom = Atom(name: '_AppStore.isPlay');

  @override
  bool get isPlay {
    _$isPlayAtom.reportRead();
    return super.isPlay;
  }

  @override
  set isPlay(bool value) {
    _$isPlayAtom.reportWrite(value, super.isPlay, () {
      super.isPlay = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AppStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$playListAtom = Atom(name: '_AppStore.playList');

  @override
  List<Category> get playList {
    _$playListAtom.reportRead();
    return super.playList;
  }

  @override
  set playList(List<Category> value) {
    _$playListAtom.reportWrite(value, super.playList, () {
      super.playList = value;
    });
  }

  final _$clearPlayListAsyncAction = AsyncAction('_AppStore.clearPlayList');

  @override
  Future<void> clearPlayList() {
    return _$clearPlayListAsyncAction.run(() => super.clearPlayList());
  }

  final _$setDarkModeAsyncAction = AsyncAction('_AppStore.setDarkMode');

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void addPlayListItem(Category productList) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.addPlayListItem');
    try {
      return super.addPlayListItem(productList);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotification(bool val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setNotification');
    try {
      return super.setNotification(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlay(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setPlay');
    try {
      return super.setPlay(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
isNotificationOn: ${isNotificationOn},
isPlay: ${isPlay},
isLoading: ${isLoading},
playList: ${playList}
    ''';
  }
}
