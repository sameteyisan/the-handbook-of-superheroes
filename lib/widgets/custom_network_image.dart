import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.url, this.size, this.borderRadius});
  final String url;
  final double? size;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      height: (size ?? Get.width * 0.62).w,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      cache: true,
      border: Border.all(color: CColors.foregroundBlack, width: 1),
      shape: BoxShape.rectangle,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
    );
  }
}
