import 'package:flutter/material.dart';
import 'package:fork_updater/view/home/view/home_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/lang/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const ForkUpdater());
}

class ForkUpdater extends StatelessWidget {
  const ForkUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation.translationKeys,
      locale: const Locale('en', 'US'),
      fallbackLocale: Get.deviceLocale,
      enableLog: true,
      navigatorKey: Get.key,
      navigatorObservers: [GetObserver()],
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.purple[600]),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
        primarySwatch: Colors.purple,
        /* dark theme settings */
      ),
      theme: ThemeData(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.purple[600]),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
        primarySwatch: Colors.purple,
      ),
      home: HomeView(),
    );
  }
}
