import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  if (Platform.isIOS) {
    return await _requestStoragePermission();
  } 

  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final int sdkInt = androidInfo.version.sdkInt;
    return sdkInt > 32 ? await _requestPhotosPermission() : await _requestStoragePermission();
  }

  return false;
}

Future<bool> _requestPhotosPermission() async {
  PermissionStatus status = await Permission.photos.status;
  if (status != PermissionStatus.granted) {
    status = await Permission.photos.request();
  }
  return status == PermissionStatus.granted;
}

Future<bool> _requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    status = await Permission.storage.request();
  }
  return status == PermissionStatus.granted;
}
