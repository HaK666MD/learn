import 'dart:io';
import 'package:dio/dio.dart';
import 'package:learn/config/di/locator.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadService {
  final Dio _dio = getIt<Dio>();

  Future<void> startDownloading(
    Function(int, int) onProgress,
    String url,
  ) async {
    try {
      final filePath = await _getFilePath(url);
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          onProgress(receivedBytes, totalBytes);
        },
        deleteOnError: true,
      );
    } on DioException catch (e) {
      throw 'Exception during download: ${e.message}';
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  Future<String> _getFilePath(String url) async {
    try {
      final response = await _dio.head(url);
      final mimeType = response.headers.value('content-type');
      if (mimeType == null) throw 'Could not determine MIME type';
      
      final fileExtension = mimeType.split('/').last;
      final baseName = url.split('/').last;
      final fileName = baseName.length > 8 ? baseName.substring(0, 8) : baseName;
      final uniqueFileName = '${fileName}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      return await _getDownloadDirectory(uniqueFileName);
    } on DioException catch (e) {
      throw 'Exception while getting MIME type: ${e.message}';
    }
  }

  Future<String> _getDownloadDirectory(String filename) async {
    try {
      Directory? directory;
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download/');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
      if (directory == null) throw 'Unable to get the download directory';
      return '${directory.path}/$filename';
    } catch (e) {
      throw 'Error retrieving download directory path: $e';
    }
  }
}
