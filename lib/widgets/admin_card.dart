import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_ink_well.dart';

class AdminCard extends StatelessWidget {
  const AdminCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.invertColors = false,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;
  final bool invertColors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomInkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: invertColors
                  ? [
                      CColors.foregroundBlack.withOpacity(0.6),
                      CColors.foregroundBlack.withOpacity(0.4),
                      CColors.foregroundBlack,
                    ]
                  : [
                      CColors.foregroundBlack,
                      CColors.foregroundBlack.withOpacity(0.4),
                      CColors.foregroundBlack.withOpacity(0.6),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: CColors.subtitleColor,
                shadows: Const.shadows,
                size: 28.sp,
              ),
              const SizedBox(height: 4),
              Text(
                title.tr,
                style: Styles.bigTitle.copyWith(letterSpacing: 1.4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
