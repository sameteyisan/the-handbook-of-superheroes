import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final Color disabledColor;
  final double size;
  final double radius;
  final Widget icon;

  const CustomIconButton({
    Key? key,
    this.onTap,
    this.backgroundColor = CColors.mainColor,
    this.disabledColor = CColors.textColor,
    this.size = 46,
    this.radius = 16,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      color: onTap == null ? disabledColor : backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
