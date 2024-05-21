import 'package:flutter/material.dart';
import 'package:learn/config/network/file_download.dart';

class DownloadProvider with ChangeNotifier {
  double _progress = 0.0;
  String? _errorMessage;

  double get progress => _progress;
  String? get errorMessage => _errorMessage;

  void startDownload(String url) {
    _progress = 0.0;
    _errorMessage = null;
    notifyListeners();

    FileDownloadService().startDownloading(
      (receivedBytes, totalBytes) {
        _progress = receivedBytes / totalBytes;
        notifyListeners();
      },
      url,
    ).catchError((error) {
      _errorMessage = error.toString();
      notifyListeners();
    });
  }
}
