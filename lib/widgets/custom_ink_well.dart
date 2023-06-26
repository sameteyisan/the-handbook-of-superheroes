import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.radius = 24,
  }) : super(key: key);

  final Widget child;
  final void Function()? onTap;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
