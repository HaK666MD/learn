import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn/config/di/locator.dart';
import 'package:learn/data/repository/gallery_repository.dart';
import 'package:learn/domain/models/photo/photo_model.dart';

class GalleryProvider extends ChangeNotifier {

  List<Photo> _photos = [];
  List<Photo> get photos => _photos;

  Photo? _photo;
  Photo? get photo => _photo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Future<void> getPhotos() async {
    try {
      _isLoading = true;
      _photos = await getIt<GalleryRepository>().getPhotoList();
      _error = '';
    } on DioException catch (e) {
      _error = e.message.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPhoto(int id) async {
    _isLoading = true;
    getIt<GalleryRepository>().getPhotoById(id).then((photo) {
      _photo = photo;
      _error = '';
    }).catchError((e) {
      if (e is DioException) _error = e.message.toString();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
