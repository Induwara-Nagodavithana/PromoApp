import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  DataStore._privateConstructor();

  static final DataStore _instance = DataStore._privateConstructor();

  static DataStore get shared => _instance;

  static Future<SharedPreferences> _store = SharedPreferences.getInstance();

  // setInviteBranchId(String id) {
  //   _store.then((store) {
  //     store.setString("inviteBranchId", id);
  //   });
  // }

  // deleteInviteBranchId() {
  //   _store.then((store) {
  //     store.remove("inviteBranchId");
  //   });
  // }

  // Future<String> getInviteBranchId() async {
  //   final SharedPreferences store = await _store;
  //   final inviteBranchId = store.getString("inviteBranchId");
  //   return inviteBranchId;
  // }

  late String _token;
  late String _userId;
  List<dynamic> _notifications = [];

  Future<void> clearAll() async {
    final SharedPreferences store = await _store;
    // _token = '';
    await store.clear();
  }

  Future<List<dynamic>> getNotifications() async {
    final SharedPreferences store = await _store;
    final notifications = store.getString("notifications");
    print(notifications);
    return jsonDecode(notifications ?? '[]');
  }

  set setOneNotification(dynamic value) {
    print(value);
    _store.then((store) {
      _notifications = jsonDecode(store.getString("notifications") ?? '[]');
      _notifications.insert(0, value);
      String newNotifications = jsonEncode(_notifications);
      store.setString("notifications", newNotifications);
    });
  }

  Future<bool> getIsFirstTime() async {
    final SharedPreferences store = await _store;
    final _isFirstTime = store.getBool("isFirstTime");
    return _isFirstTime ?? true;
  }

  setIsFirstTime(bool value) {
    _store.then((store) {
      store.setBool("isFirstTime", value);
    });
  }

  Future<String> getUserId() async {
    if (_userId == null || _userId == 0) {
      final SharedPreferences store = await _store;
      final uid = store.getString("userId");
      _userId = uid!;
      return uid;
    } else {
      return _userId;
    }
  }

  set setUserId(String value) {
    _userId = value;
    _store.then((store) {
      store.setString("userId", value);
    });
  }

  Future<String> getToken() async {
    if (_token.isEmpty) {
      final SharedPreferences store = await _store;
      final token = store.getString("token");
      _token = token!;
      return token;
    } else {
      return _token;
    }
  }

  set setToken(String token) {
    _token = token;
    _store.then((store) {
      store.setString("token", token ?? "");
    });
  }
}
