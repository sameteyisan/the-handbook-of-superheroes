import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/shimmer_wrapper.dart';

class PlaceholderSuperheroCard extends StatelessWidget {
  const PlaceholderSuperheroCard({Key? key, this.height, this.width}) : super(key: key);
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Container(
            width: width,
            height: (height ?? Get.width * 0.7),
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
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CColors.backgroundcolor.withValues(alpha: 0.6),
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
    );
  }
}
