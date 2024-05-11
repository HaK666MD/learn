import 'package:flutter/material.dart';
import 'package:learn/ui/screens/navbar/navbar_screen.dart';
import 'package:learn/ui/screens/todo/todo_add_screen.dart';
import 'package:learn/ui/screens/todo/todo_list_screen.dart';

abstract class Routes {
  static const String navScreen = '/nav_screen';
  static const String todoListScreen = '/todo_list';
  static const String todoAddScreen = '/todo_add';
}

GlobalKey<NavigatorState> globalNavigator = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.navScreen:
      return MaterialPageRoute(
        builder: (_) => const NavBarScreen(),
        settings: settings,
      );
    case Routes.todoListScreen:
      return MaterialPageRoute(
        builder: (_) => const TodoListScreen(),
        settings: settings,
      );
    case Routes.todoAddScreen:
      return MaterialPageRoute(
        builder: (_) => const TodoAddScreen(),
        settings: settings,
      );
  }
  return null;
}
