import 'package:flutter/material.dart';
import 'package:learn/config/router/page_arguments.dart';
import 'package:learn/ui/screens/gallery/gallery_provider.dart';
import 'package:provider/provider.dart';

class GalleryPhotoScreen extends StatelessWidget {
  const GalleryPhotoScreen({super.key, required this.args});

  final PageArguments args;

  @override
  Widget build(BuildContext context) {
    Provider.of<GalleryProvider>(context, listen: false).getPhoto(args.id);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Consumer<GalleryProvider>(
            builder: (_, provider, __) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (provider.error.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (ModalRoute.of(context)!.isCurrent) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          provider.error,
                        ),
                      ),
                    );
                  }
                });
                return const SizedBox.shrink();
              }
              return Hero(
                  tag: provider.photo!.id,
                  child: Center(child: Image.network(provider.photo!.url)),
              );
            },
          ),
        ),
      ),
    );
  }
}
