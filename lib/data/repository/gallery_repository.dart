import 'package:injectable/injectable.dart';
import 'package:learn/config/di/locator.dart';
import 'package:learn/data/api/gallery/gallery_api.dart';
import 'package:learn/domain/models/photo/photo_model.dart';

@injectable
class GalleryRepository {
  Future<List<Photo>> getPhotoList() async {
    return await getIt<GalleryApi>().getPhotos();
  }

  Future<Photo> getPhotoById(int id) async {
    return await getIt<GalleryApi>().getPhoto(id);
  }
}
