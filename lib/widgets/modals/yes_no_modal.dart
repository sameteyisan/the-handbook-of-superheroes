import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/modal_action_buttons.dart';

class YesNoModal extends StatelessWidget {
  const YesNoModal({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: CColors.foregroundBlack,
      elevation: 10,
      title: Text(
        "Warning",
        style: Styles.title.copyWith(color: CColors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(color: CColors.textColor, fontSize: 14.sp),
            ),
          ),
        ],
      ),
      actions: [
        ModalActionButtons(
          right: "Yes",
          left: "Cancel",
          onPressedRight: () => Get.back(result: true),
          onPressedLeft: Get.back,
        )
      ],
    );
  }

  static Future<bool?> open(String text) async => await Get.dialog(YesNoModal(text: text));
}
