import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fork_updater/view/home/service/home_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/home_model.dart';

class HomeViewModel extends GetxController {
  final IHomeService homeService;
  HomeViewModel(this.homeService);

  final box = GetStorage();

  TextEditingController projectPathController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();

  String? directory;

  var isVideo = false.obs;
  var imagePath = ''.obs;
  var isLoading = false.obs;
  var homeList = <HomeModel>[].obs;

  var branchList = [].obs;
  var commandOutput = ''.obs;

  var searchResult = <FileSystemEntity>[].obs;

  void addBranchToList() {
    branchList.add(branchNameController.text);
  }

  void deleteBranchToList() {
    branchList.removeWhere((element) => element == branchNameController.text);
    // return array;
  }

  void runCommand(String command) {
    try {
      Process.run(command, [], runInShell: true).then((ProcessResult results) {
        commandOutput.value = results.stdout as String;
      });
    } catch (error) {
      Get.snackbar("ERROR ", error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3));
    }
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
