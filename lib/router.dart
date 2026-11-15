import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ⭐ _rootNavigatorKey 是什麼：
//   GlobalKey<NavigatorState> = 一個「全局唯一」的鑰匙，
//   指向 app 最頂層的那個 Navigator（Root Navigator）。
//
//   為什麼需要它？
//   1. 之後如果加「登入頁、全屏 modal」這種不屬於任何 tab、
//      要蓋住底部導航欄的頁面，需要在 GoRoute 上標
//      parentNavigatorKey: _rootNavigatorKey，告訴 go_router
//      「這頁放到最頂層，不要塞進某個 branch」。
//   2. 想從非 widget 的代碼（如 service、通知回調）主動跳頁時，
//      可以用 _rootNavigatorKey.currentState / .currentContext 取到 root。
//
//   底線開頭 = 檔案內私有，不給外部 import。
final _rootNavigatorKey = GlobalKey<NavigatorState>();