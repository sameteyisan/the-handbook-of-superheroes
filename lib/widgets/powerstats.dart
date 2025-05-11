import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/extentions.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';

class PowerStats extends StatelessWidget {
  const PowerStats({super.key, required this.kv});
  final MapEntry<String, dynamic> kv;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: CColors.iconColor.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  kv.key.formatKey,
                  style: const TextStyle(color: CColors.textColor),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: CColors.foregroundBlack,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Const.powerstatColors[kv.key],
                        ),
                        child: Slider(
                          value: ((int.tryParse(kv.value) ?? 0) / 100),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      kv.value == "null" ? "??" : kv.value,
                      style: const TextStyle(color: CColors.textColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().flip(delay: 400.ms);
  }
}
