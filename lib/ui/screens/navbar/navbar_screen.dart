import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn/config/router/gallery_router.dart';
import 'package:learn/ui/screens/todo/todo_list_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {  
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (galleryNavigator.currentState!.canPop()) {
          galleryNavigator.currentState!.pop();
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_bar),
              label: 'Local',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.api),
              label: 'API',
            ),
          ],
        ),
        body: switch (selectedIndex) {
          0 => const TodoListScreen(),
          1 => Navigator(
              key: galleryNavigator,
              observers: [HeroController()],
              onGenerateRoute: onGenerateRoute,
              initialRoute: GalleryRoutes.gallery,
            ),
          _ => const Center(
              child: Text('Not Found'),
            )
        },
      ),
    );
  }
}
