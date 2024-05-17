import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn/config/di/locator.dart';
import 'package:path_provider/path_provider.dart';

class FileDownload {
  final Dio _dio = getIt<Dio>();

  Future<String?> _getMimeType(String url) async {
    try {
      final response = await _dio.head(url);
      return response.headers.value('content-type');
    } catch (e) {
      debugPrint('Exception while getting MIME type: $e');
      return null;
    }
  }

  Future<String> _getFilePath(String filename) async {
    try {
      Directory? dir;
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
        debugPrint(dir.path);
      } else {
        dir = Directory('/storage/emulated/0/Download/');
        if (!await dir.exists()) {
          dir = await getExternalStorageDirectory();
        }
      }
      if (dir != null) {
        return '${dir.path}/$filename';
      } else {
        throw Exception('Unable to get directory');
      }
    } catch (err) {
      debugPrint('Cannot get download folder path: $err');
      rethrow;
    }
  }

  void startDownloading(
    context,
    Function(int, int) onProgress,
    String url,
  ) async {
    try {
      String? mimeType = await _getMimeType(url);
      if (mimeType != null) {
        String fileExtension = mimeType.split('/').last;
        String fileName = '${url.split('/').last}.$fileExtension';
        String filePath = await _getFilePath(fileName);

        await _dio.download(
          url,
          filePath,
          onReceiveProgress: (receivedBytes, totalBytes) {
            onProgress(receivedBytes, totalBytes);
          },
          deleteOnError: true,
        );
        Navigator.of(context).pop();
      } else {
        debugPrint('Unable to determine MIME type');
      }
    } catch (e) {
      debugPrint('Exception during download: $e');
    }
  }
}
