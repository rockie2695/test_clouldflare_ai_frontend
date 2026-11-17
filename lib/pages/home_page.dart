import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 為了用 context.push

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 每個頁面自己包 Scaffold。
    // 注意：HomeShell 也有 Scaffold，但那是「外殼」，
    // 內層頁面的 AppBar / body 要自己的 Scaffold 才對。
    // 兩層 Scaffold 是正常且推薦的做法。
    return Scaffold(
      appBar: AppBar(title: const Text('首頁')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            // const SizedBox(height: 16),
            // FilledButton(
            //   // context.push：把新頁面「疊加」到當前 branch 的棧上。
            //   // 因為 /home/detail/:id 沒有標 parentNavigatorKey，
            //   // 所以它進入的是「首頁 branch 自己的 Navigator」，
            //   // 底部導航欄會保留 → 這正是我們要的效果。
            //   //
            //   // 對比 context.go：go 是「替換」當前棧頂（常用於 tab 切換、deep link），
            //   // push 才是「疊加」。
            //   onPressed: () => context.push('/home/detail/42'),
            //   child: const Text('打開商品 42'),
            // ),
          ],
        ),
      ),
    );
  }
}