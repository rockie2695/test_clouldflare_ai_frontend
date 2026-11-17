import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';
import 'pages/account_page.dart';
import 'shell/home_shell.dart';
import 'pages/text2img_page.dart';
import 'pages/img2img_page.dart';

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

// ⭐ appRouter：整個 app 的路由總表
//   main.dart 會把這個實例交給 MaterialApp.router。

final GoRouter appRouter = GoRouter(
  // 把上面那把鑰匙交給 go_router，
  // 意思是「你建 root Navigator 時用這個 key」。
  // 不指定也行（go_router 內部會自己產生），
  // 但指定了才能在上面說的情境中主動引用它。
  navigatorKey: _rootNavigatorKey,
  // app 啟動時落在哪個路徑（= 預設顯示哪個 tab）
  initialLocation: '/home',
  // routes：這個 app 的所有路由規則
  routes: [
    // ⭐ StatefulShellRoute.indexedStack：
    //   這是「多 tab + 每 tab 獨立返回棧」的核心。
    //   indexedStack 的意思：切走的 tab 不會被銷毀，
    //   只是被隱藏（IndexedStack 機制），所以狀態保留。
    StatefulShellRoute.indexedStack(
      // builder：決定「外殼長什麼樣」。
      // go_router 把 navigationShell（多 tab 容器）傳給你，
      // 你把它塞進自訂的 HomeShell。
      // HomeShell 負責畫底部導航欄，見 home_shell.dart。
      builder: (context, state, navigationShell) =>
          HomeShell(navigationShell: navigationShell),
      // branches：每個 tab 一個 branch。
      // 陣列順序 = 底部導航欄的 index（0, 1, 2）。
      // 順序必須跟 HomeShell 裡 NavigationBar 的 destinations 順序一致！
      branches: [
        // ── Branch 0：首頁 tab ─────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),

              // routes：這個路徑下的子路由。
              // 子路由的 path 不要加 leading "/"，
              // 完整路徑 = 父 path + "/" + 子 path。
              //   routes: [
              //     GoRoute(
              //       // 完整路徑：/home/detail/:id
              //       // :id 是路徑參數，用 state.pathParameters['id'] 取。
              //       path: 'detail/:id',
              //       builder: (context, state) =>
              //           DetailPage(id: state.pathParameters['id']!),
              //       // 這頁沒有 parentNavigatorKey，
              //       // 所以它會被 push 進「首頁 branch 自己的 Navigator」，
              //       // 結果就是底部導航欄仍然可見（我們要的效果）。
              //     ),
              //   ],
            ),
          ],
        ),

        // ── Branch 1：搜尋 tab ─────────────────────────────
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/search',
        //       builder: (context, state) => const SearchPage(),
        //     ),
        //   ],
        // ),

        // ── Branch 2：我的 tab ─────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/text2img',
              builder: (context, state) => const Text2ImgPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/img2img',
              builder: (context, state) => const Img2ImgPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const AccountPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
