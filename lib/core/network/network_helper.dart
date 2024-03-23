// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

mixin NetworkHelper {
  void showLog(dynamic message) {
    Logger().wtf(message);
  }
}
