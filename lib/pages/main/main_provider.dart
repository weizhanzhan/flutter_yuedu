import 'package:flutter/material.dart';
import 'package:flutter_yuedu/api/http.dart';
import 'package:flutter_yuedu/sqlite/sqlite.dart';

const URL = "app/conf";

class MainProvider with ChangeNotifier {
  MainProvider() {
    fetchMessage();
    fetchConfig();
  }
  int _messageCount = 0;

  // tabBar选中索引
  int _tabBarSelectedIndex = 0;
  int get getTabBarSelectedIndex => _tabBarSelectedIndex;
  set setTabBarSelectedIndex(int value) {
    _tabBarSelectedIndex = value;
  }

  // 课程 url
  String _courseUrl;
  String get courseUrl => _courseUrl;

  // 处理后显示的消息
  String get getMessageCount =>
      _messageCount < 100 ? _messageCount.toString() : "99+";
  // 是否有消息
  bool get isMessageCount => _messageCount > 0;

  void cleanMessage() {
    _messageCount = 0;
    notifyListeners();
  }

  Future<void> fetchConfig() async {
    KeyValueStore.get(URL).then((item) {
      print("缓存 url:" + item.content.toString());
      _courseUrl = item.content.toString();
    });

    Http.get(URL, version: "").then((res) {
      _courseUrl = res.data["config"]["courseUrl"];
      KeyValueStore.add(URL, _courseUrl);
    });
  }

  // 获取消息数据
  Future<void> fetchMessage() async {
    print("开始获取未读消息");
    Future.delayed(const Duration(seconds: 6), () {
      _messageCount = 12;
      notifyListeners();
    });
    Future.delayed(const Duration(seconds: 10), () {
      _messageCount = 100;
      notifyListeners();
    });
    Future.delayed(const Duration(seconds: 17), () {
      _messageCount = 14;
      notifyListeners();
    });
    Future.delayed(const Duration(seconds: 47), () {
      _messageCount = 100;
      notifyListeners();
    });
  }
}
