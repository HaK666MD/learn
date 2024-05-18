import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn/config/di/locator.dart';
import 'package:path_provider/path_provider.dart';

class FileDownload {
  final Dio _dio = getIt<Dio>();

  void startDownloading(
    Function(int, int) onProgress,
    String url,
  ) async {
    try {
      String? filePath = await _getFilePath(url);
      if (filePath != null) {
        await _dio.download(
          url,
          filePath,
          onReceiveProgress: (receivedBytes, totalBytes) {
            onProgress(receivedBytes, totalBytes);
          },
          deleteOnError: true,
        );
      } 
    } catch (e) {
      debugPrint('Exception during download: $e');
    }
  }

  Future<String?> _getFilePath(String url) async {
    try {
      final response = await _dio.head(url);
      final mimeType = response.headers.value('content-type');
      if (mimeType != null) {
        String fileExtension = mimeType.split('/').last;
        String baseName = url.split('/').last;
        String fileName = baseName.length > 5 ? baseName.substring(0, 5) : baseName;
        return _setFileToDir('$fileName.$fileExtension');
      }
    } catch (e) {
      throw Exception('Exception while getting MIME type: $e');
    }
    return null;
  }

  Future<String> _setFileToDir(String filename) async {
    try {
      Directory? dir;
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
        debugPrint(dir.path);
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for Android
        if (!await dir.exists()) {
          dir = await getExternalStorageDirectory();
        }
      }

      if (dir != null) {
        String path = '${dir.path}/$filename';
        String newPath = path;
        int counter = 1;
        String fileExtension = filename.contains('.') ? filename.split('.').last : '';
        String fileNameWithoutExt = filename.replaceAll('.$fileExtension', '');
        while (await File(newPath).exists()) {
          newPath = '${dir.path}/$fileNameWithoutExt($counter).$fileExtension';
          counter++;
        }
        return newPath;
      } else {
        throw Exception('Unable to get directory');
      }
    } catch (err) {
      debugPrint('Cannot get download folder path: $err');
      rethrow;
    }
  }
}
