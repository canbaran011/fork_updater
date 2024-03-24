import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fork_updater/view/home/service/home_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  dynamic timer;

  List<String> commandList = ['cd ', 'pwd', 'git pull upstream '];

  bool get isBranchListEmpty => branchList.isEmpty;
  bool get isFolderPathEmpty => folderPath.trim().isEmpty;

  void addBranchToList() {
    if (!branchList.contains(branchNameController.text)) {
      branchList.add(branchNameController.text);
    } else {
      Get.snackbar('Selamlar ', 'Zaten var bu branch',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP);
    }
  }

  void deleteBranchToList() {
    if (branchList.contains(branchNameController.text)) {
      branchList.removeWhere((element) => element == branchNameController.text);
    } else {
      Get.snackbar('Selamlar ', 'Eklenmemis bu branch',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP);
    }
  }

  runPeriodic() async {
    await runCommandList();
    timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) async {
      DateTime now = DateTime.now();
      if (now.hour == 13 && now.minute == 39) {
        await runCommandList();
      } else if (now.hour == 11 && now.minute == 30) {
        await runCommandList();
      } else if (now.hour == 15 && now.minute == 30) {
        await runCommandList();
      }
    });
  }

  runCommandList() async {
    DateTime moment = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(moment);
    commandOutput.value += '\n\n\n$formattedDate ====process started===\n\n';
    Process process = await Process.start('powershell.exe', []);
    try {
      // PowerShell output stream for reading
      process.stdout.transform(utf8.decoder).listen((data) {
        
        commandOutput.value += data;
      });
      process.stderr.transform(utf8.decoder).listen((data) {
        
        commandOutput.value += data;
      });

      process.stdin.writeln((commandList[0] + folderPath.value));
      process.stdin.writeln(commandList[1]);

      for (var element in branchList) {
        process.stdin.writeln(commandList[2] + element);
      }
      process.stdin.close();
    } catch (error) {
      commandOutput.value += error.toString();
      killProcess(process);
    } finally {
      killProcess(process);
    }
  }

  killProcess(Process process) {
    process.exitCode.then((value) {
      process.kill();
    });
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
