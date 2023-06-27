import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/shimmer_wrapper.dart';

class PlaceholderSuperheroCard extends StatelessWidget {
  const PlaceholderSuperheroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ShimmerWrapper(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Container(
              height: Get.width * 0.7.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: CColors.foregroundBlack,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 56.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CColors.backgroundcolor.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
