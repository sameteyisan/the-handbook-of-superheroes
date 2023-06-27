import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({
    Key? key,
    required this.child,
    this.borderRadius,
    this.showShimmer = true,
    this.duration,
    this.direction = ShimmerDirection.ltr,
  }) : super(key: key);
  final Widget child;
  final BorderRadius? borderRadius;
  final bool showShimmer;
  final Duration? duration;
  final ShimmerDirection direction;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Stack(
        children: [
          child,
          if (showShimmer)
            Positioned.fill(
              child: IgnorePointer(
                child: Shimmer.fromColors(
                  direction: direction,
                  period: duration ?? 2.seconds,
                  baseColor: Colors.transparent,
                  highlightColor: CColors.textColor.withOpacity(0.2),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
