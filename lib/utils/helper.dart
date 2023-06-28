import 'package:flutter_easyloading/flutter_easyloading.dart';

class Helper {
  static void showToast(String msg) => EasyLoading.showToast(
        msg,
        toastPosition: EasyLoadingToastPosition.bottom,
      );

  static Future<void> showError(String msg) async {
    return await EasyLoading.showError(
      msg,
      dismissOnTap: true,
      maskType: EasyLoadingMaskType.black,
    );
  }
}
