import 'package:flutter/material.dart';
import 'package:learn/config/di/locator.dart';
import 'package:learn/ui/screens/gallery/gallery_provider.dart';
import 'package:learn/ui/screens/todo/todo_provider.dart';
import 'package:learn/config/router/app_router.dart';

import 'package:provider/provider.dart';

void main() {
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => GalleryProvider()),
      ],
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              shape: CircleBorder(),
            ),
          ),
          navigatorKey: globalNavigator,
          onGenerateRoute: onGenerateRoute,
          initialRoute: Routes.navScreen,
        );
      },
    );
  }
}
