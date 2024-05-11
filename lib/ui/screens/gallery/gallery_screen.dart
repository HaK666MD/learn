import 'package:flutter/material.dart';
import 'package:learn/config/router/gallery_router.dart';
import 'package:learn/ui/screens/gallery/gallery_provider.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await context.read<GalleryProvider>().getPhotos(),
          child: FutureBuilder(
            future: context.read<GalleryProvider>().getPhotos(),
            builder: (_, __) {
              return Consumer<GalleryProvider>(
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
                          SnackBar(content: Text(provider.error)),
                        );
                      }
                    });
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: GridView.count(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        children: List.generate(
                          provider.photos.length,
                          (index) {
                            return GestureDetector(
                              onTap: () => galleryNavigator.currentState!.pushNamed(
                                GalleryRoutes.galleryImage,
                                arguments: {'id': provider.photos[index].id},
                              ),
                              child: Hero(
                                tag: provider.photos[index].id,
                                child: GridTile(
                                  child: Image.network(provider.photos[index].url),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
