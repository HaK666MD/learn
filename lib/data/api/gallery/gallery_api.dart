import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:learn/config/network/constants.dart';
import 'package:learn/domain/models/photo/photo_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'gallery_api.g.dart';

@lazySingleton
@RestApi(baseUrl: baseUrl)
abstract class GalleryApi {
  @factoryMethod
  factory GalleryApi(Dio dio) = _GalleryApi;

  @GET(EndPoints.photos)
  Future<List<Photo>> getPhotos();

  @GET(EndPoints.photo)
  Future<Photo> getPhoto(@Path('id') int photoId);
}