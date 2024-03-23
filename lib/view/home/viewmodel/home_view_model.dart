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

  var isLoading = false.obs;

  var commandOutput = ''.obs;
  var folderPath = ''.obs;
  var branchList = [].obs;

  var commandList = ['cd ', 'pwd', 'git status'];

  bool get isBranchListEmpty => branchList.isEmpty;
  bool get isFolderPathEmpty => folderPath.trim().isEmpty;

  void addBranchToList() {
    if (!branchList.contains(branchNameController.text)) {
      branchList.add(branchNameController.text);
    }
  }

  void deleteBranchToList() {
    branchList.removeWhere((element) => element == branchNameController.text);
  }

  runCommandList() async {
    commandOutput.value += await executePowerShellCommand(
        '${commandList[0]}${folderPath.value}\n${commandList[1]}\n${commandList[2]}');
  }

  Future<String> executePowerShellCommand(String command) async {
    try {
      // Spawning a new process for PowerShell
      ProcessResult processResult = await Process.run(
        'powershell',
        ['-Command', command],
      );

      // Checking for errors

      if (processResult.exitCode != 0) {
        Get.snackbar('Failed to execute PowerShell command', 'hata var');
        throw Exception('Failed to execute PowerShell command');
      }

      // Returning the output
      return (' ==>>\n $command \n ${processResult.stdout}');
    } catch (e) {
      return 'Error: $e';
    }
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
