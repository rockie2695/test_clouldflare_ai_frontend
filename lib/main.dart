import 'package:material_ui/material_ui.dart';
// 路由總表，裡面定義了 appRouter
import 'router.dart';

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
      title: 'Cloudflare image ai',
      // 全域主題：Material 3、以藍色為種子色
      theme: ThemeData(
        // ① 使用 Material 3 设计规范
        //    - 决定整体视觉风格（圆角、阴影、配色逻辑）
        //    - NavigationBar / FilledButton 等 M3 组件必须有它才正常显示
        useMaterial3: true,
        // ② 用一颗「种子色」自动生成整套配色方案
        //    Flutter 会据此推导出 primary / secondary / surface / error 等
        //    所有组件的默认颜色都会围绕这个蓝色自动协调
        colorSchemeSeed: Colors.blue,
        // ③ 单独定制「所有 NavigationBar」的默认外观
        //    在这里写一次，app 里每个 NavigationBar 不写属性都会用这里的值
        //    优先级：组件上直接写的属性 > 这里 > Flutter 内置默认
        navigationBarTheme: NavigationBarThemeData(
          // 底部导航栏的背景色：白色
          backgroundColor: Colors.white,
          // 选中 tab 下方「胶囊指示器」的底色
          // Color(0xFF1E88E5) = 一个蓝色（0xFF = 不透明，后面 6 位是 RGB）
          // .withOpacity(0.15) = 变成 15% 透明度，即很淡的蓝色
          indicatorColor: const Color(0xFF1E88E5).withValues(alpha: 0.15),
          // ④ 文字标签样式：随「选中/未选中」状态变化
          //    WidgetStateProperty = 「属性值依赖组件状态」的表达方式
          //    resolveWith(函数) = 传一个函数，Flutter 渲染时按当前状态调用它取值
          //    states 是一个集合，因为组件可能同时处于多个状态
          //    （例如「已选中 + 鼠标悬停」）
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            // 检查当前状态集合里是否包含「已选中」
            final selected = states.contains(WidgetState.selected);

            return TextStyle(
              // 选中 → 蓝色；未选中 → 灰色
              color: selected ? const Color(0xFF1E88E5) : Colors.grey,
              // 选中 → 半粗体(w600)；未选中 → 常规
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              // 字号固定 12，不随状态变
              fontSize: 12,
            );
          }),

          // ⑤ 图标样式：同样随「选中/未选中」变化
          //    结构与 labelTextStyle 完全一致，只是控制的是 Icon
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);

            return IconThemeData(
              // 选中 → 蓝色；未选中 → 灰色
              color: selected ? const Color(0xFF1E88E5) : Colors.grey,
              // 选中 → 26px（放大 2px 更突出）；未选中 → 24px
              size: selected ? 26 : 24,
            );
          }),
        ),
      ),
      // 把 GoRouter 實例掛進來。
      // 從此所有頁面切換都由 appRouter 控制，
      // Flutter 不再自己管頁面棧（除了 root navigator 內部）。
      routerConfig: appRouter,
    );
  }
}
