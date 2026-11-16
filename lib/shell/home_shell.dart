import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ⭐ HomeShell：所有 tab 共用的「外殼」。
//   職責：
//   1. 把「目前選中的 tab 頁面」顯示在 body
//   2. 畫底部導航欄
//   不負責：頁面內容（那是各 Page 的事）、路由規則（那是 router.dart 的事）
class HomeShell extends StatelessWidget {
  // navigationShell 是 go_router 傳進來的「多 tab 容器」，
  // 它本身就是一個 Widget，內部已管好各 branch 的 Navigator 與狀態。
  // 對外只暴露 currentIndex 和 goBranch()。
  final StatefulNavigationShell navigationShell;

  const HomeShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 把多 tab 容器直接放進 body。
      // 它會自動只顯示「目前選中 branch」的內容，
      // 其他 branch 被 IndexedStack 隱藏但保留狀態。
      body: navigationShell,

      // 底部導航欄
      bottomNavigationBar: NavigationBar(
        // 目前選中第幾個 tab（決定哪個 icon 亮起）
        selectedIndex: navigationShell.currentIndex,

        // 點擊某個 tab 時要做的事
        onDestinationSelected: (i) => navigationShell.goBranch(
          i,
          // 如果點的正是「目前已選中的 tab」(i == currentIndex)，
          // 則該 branch 重置回首頁（回到 /home 或 /search 等根頁）。
          // 這是原生 app 常見行為：再點一次當前 tab 就回到頂層。
          initialLocation: i == navigationShell.currentIndex,
        ),

        // 三個 tab 的外觀。
        // ⚠️ 順序必須跟 router.dart 裡 branches 的順序完全一致：
        //    index 0 → /home, index 1 → /search, index 2 → /profile
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home), // 選中時用的 icon
            label: '首頁',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: '搜尋',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
