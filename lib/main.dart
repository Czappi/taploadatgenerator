import 'package:flutter/material.dart';
import 'package:taploadatgenerator/editor.dart';
import 'package:taploadatgenerator/mainpage.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/home",
        builder: (context, state) => const Mainpage(),
      ),
      GoRoute(
        path: "/editor/:link",
        builder: (context, state) => EditorPage(
          key: state.pageKey,
          link: state.params['link'] ?? 'idkbajvan',
        ),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
