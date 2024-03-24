// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fork_updater/core/extensions/context_extension.dart';
import 'package:fork_updater/core/network/vexana_manager.dart';
import 'package:fork_updater/view/home/service/home_service.dart';
import 'package:fork_updater/view/home/viewmodel/home_view_model.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ctrl = Get.put(
      HomeViewModel(HomeService(VexanaManager.instance.networkManager)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Fork Updater for Kamer',
          style: TextStyle(color: Color.fromARGB(255, 243, 173, 255)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ctrl.commandOutput.value = '';
            },
          ),
        ],
      ),
      // backgroundColor: Colors.black87,
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getUserInputAndListView(context),
                  getCommandLineView(context)
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  getUserInputAndListView(BuildContext context) {
    return Container(
        padding: context.paddingMedium,
        width: Get.width * 0.4,
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.purple.shade600, // You can set border color here
            width: 2, // Border width
            style: BorderStyle.solid,
          ),
        ),
        child: getFormFields(context));
  }

  getFormFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: context.paddingNormal,
            child: TextFormField(
              controller: ctrl.projectPathController,
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                labelText: 'folderPathInput'.tr,
                hintText: 'folderPathInputHint'.tr,
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: Icon(
                  Icons.folder,
                  color: Colors.grey,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'emptyInputMessage'.tr;
                }
                print(value);
                return null;
              },
              onChanged: (value) {
                ctrl.folderPath.value = value;
              },
            ),
          ),
          Padding(
            padding: context.paddingNormal,
            child: TextFormField(
              controller: ctrl.branchNameController,
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                suffixIcon: Stack(alignment: Alignment.center, children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.purple.shade600,
                        hoverColor: Colors.purple.shade900,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Add your button onPressed logic here
                          if (ctrl.branchNameController.text
                              .trim()
                              .isNotEmpty) {
                            ctrl.addBranchToList();
                            print('Button pressed');
                          } else {
                            Get.snackbar('HOP ', 'Bos mu orasi bi daha bak !',
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP);
                          }
                          ctrl.branchNameController.clear();
                        },
                      ),
                      IconButton(
                        color: Colors.purple.shade600,
                        hoverColor: Colors.purple.shade900,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Add your button onPressed logic here
                          if (ctrl.branchNameController.text
                              .trim()
                              .isNotEmpty) {
                            ctrl.deleteBranchToList();
                            print('Button pressed');
                          } else {
                            Get.snackbar('HOP ', 'Bos mu orasi bi daha bak !',
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP);
                          }
                          ctrl.branchNameController.clear();
                        },
                      ),
                    ],
                  ),
                ]),
                contentPadding: EdgeInsets.all(0.0),
                labelText: 'branchName'.tr,
                hintText: 'branchNameHint'.tr,
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: Icon(
                  Icons.account_tree,
                  color: Colors.grey,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
            ),
          ),
          Padding(
              padding: context.paddingNormal,
              child: Obx(() {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.purple.shade600,
                    padding: context.paddingLow,
                    minimumSize: Size(Get.width * 0.85, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  onPressed: ctrl.isBranchListEmpty || ctrl.isFolderPathEmpty
                      ? null
                      : () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            Get.snackbar('Selamlar ', 'Hallediyorum',
                                colorText: Colors.white,
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP);
                            await ctrl.runPeriodic();
                          }
                        },
                  child: Obx(() => ctrl.isLoading.value
                      ? Icon(Icons.watch_later_outlined)
                      : Text('syncTitle'.tr)),
                );
              })),
          Padding(
              padding: context.paddingNormal,
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('> L I S T - O F - B R A N C H E S <'),
                    Obx(() => SelectableText(
                          "${ctrl.branchList}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Consolas'),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getCommandLineView(BuildContext context) {
    return Container(
      padding: context.paddingMedium,
      width: Get.width * 0.4,
      height: Get.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.purple.shade600, // You can set border color here
          width: 2, // Border width
          style: BorderStyle.solid,
        ),
      ),
      child: SingleChildScrollView(
          child: Obx(() => Text(ctrl.commandOutput.value.isEmpty
              ? 'emptyResult'.tr
              : ctrl.commandOutput.value))),
    );
  }
}
