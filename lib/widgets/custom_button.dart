import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_ink_well.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;
  final Color? textColor;
  final bool noSize;
  final double? textSize;
  final double? radius;
  final double? height;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.color = CColors.foregroundBlack,
    this.textColor = CColors.textColor,
    this.noSize = false,
    this.textSize,
    this.radius,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      radius: 24,
      onTap: onPressed,
      child: AnimatedContainer(
        alignment: Alignment.center,
        height: 50.h,
        duration: 300.milliseconds,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(2, 2),
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 24),
        ),
        child: Text(
          text.tr,
          style: TextStyle(
            color: textColor,
            fontSize: textSize ?? 17.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
