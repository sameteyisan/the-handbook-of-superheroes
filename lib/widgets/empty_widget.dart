import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.url, this.text});
  final String? url;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          url ?? "assets/lotties/$url.json",
          width: Get.width * 0.4,
          repeat: false,
        ),
        const SizedBox(height: 16),
        Text(
          text ?? "The superheroes you last visited are displayed here.",
          style: Styles.title.copyWith(fontSize: 17.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}