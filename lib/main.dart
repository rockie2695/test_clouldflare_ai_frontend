import 'package:flutter/material.dart';
// import 'router.dart'

void main() {
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // routerConfig: appRouter,
    );
  }
}
