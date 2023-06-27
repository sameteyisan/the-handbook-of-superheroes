import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class ModalActionButtons extends StatelessWidget {
  const ModalActionButtons(
      {super.key,
      required this.right,
      required this.left,
      this.rightColor,
      this.onPressedRight,
      required this.onPressedLeft});
  final String right;
  final String left;
  final Color? rightColor;
  final Function()? onPressedRight;
  final Function() onPressedLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CColors.textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPressedLeft,
              child: Text(
                left,
                style: const TextStyle(color: CColors.iconColor),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: rightColor ?? CColors.mainColor,
              ),
              onPressed: onPressedRight,
              child: Text(
                right,
                style: const TextStyle(color: CColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
