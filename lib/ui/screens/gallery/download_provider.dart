import 'package:flutter/material.dart';
import 'package:learn/config/network/file_download.dart';

class DownloadProvider with ChangeNotifier {
  double _progress = 0.0;
  double get progress => _progress;

  void startDownload(url) {
    _progress = 0.0;
    FileDownload().startDownloading(
      (receivedBytes, totalBytes) {
        _progress = receivedBytes / totalBytes;
        notifyListeners();
      },
      url,
    );
  }
}
