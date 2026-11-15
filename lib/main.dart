import 'package:flutter/material.dart';
// 路由總表，裡面定義了 appRouter
// import 'router.dart'

void main() {
  // 程式入口，啟動 MainApp
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: Text('Hello World!'),
    //     ),
    //   ),
    // );
    // MaterialApp.router：
    //   用「路由驅動」模式啟動 app，頁面由 GoRouter 決定，不用 home: 參數
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // 全域主題：Material 3、以藍色為種子色
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // 把 GoRouter 實例掛進來。
      // 從此所有頁面切換都由 appRouter 控制，
      // Flutter 不再自己管頁面棧（除了 root navigator 內部）。
      // routerConfig: appRouter,
    );
  }
}
