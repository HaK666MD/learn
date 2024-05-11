import 'package:flutter/material.dart';
import 'package:learn/config/router/page_arguments.dart';
import 'package:learn/ui/screens/gallery/gallery_photo_screen.dart';
import 'package:learn/ui/screens/gallery/gallery_screen.dart';

GlobalKey<NavigatorState> galleryNavigator = GlobalKey<NavigatorState>();

abstract class GalleryRoutes {
  static const String gallery = '/gallery';
  static const String galleryImage = '/gallery_image';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case GalleryRoutes.gallery:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const GalleryScreen(),
      );
    case GalleryRoutes.galleryImage:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => GalleryPhotoScreen(
          args: PageArguments.fromMap(settings.arguments as Map<String, dynamic>),
        ),
      );
  }
  return null;
}
