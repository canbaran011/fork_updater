import 'dart:io';
import 'package:get/get.dart';

import '../model/home_model.dart';

//FileSystemEntity

class HomeViewModel extends GetxController {
  String? folderWritten = '';
  var file = <FileSystemEntity>[].obs;
  String? directory;

  var isVideo = false.obs;
  var imagePath = ''.obs;
  var isLoading = false.obs;
  var homeList = <HomeModel>[].obs;

  var searchResult = <FileSystemEntity>[].obs;

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  checkPreviewFormat(String widgetPath) {
    var ext = widgetPath.split(".").last;
  }
}
