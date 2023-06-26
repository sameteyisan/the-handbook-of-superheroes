import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/utils/extentions.dart';

class DetailPanel extends StatelessWidget {
  const DetailPanel({super.key, required this.kv});
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
                  color: CColors.dialogColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(kv.key.formatKey),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: CColors.dialogColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: kv.value is List
                    ? Text(kv.value.join("\n"))
                    : Text(kv.value == "null"
                        ? "Unknown"
                        : kv.value == ""
                            ? "-"
                            : kv.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}