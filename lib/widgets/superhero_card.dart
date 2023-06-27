import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/screens/superhero_details_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_icon_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';

class SuperheroCard extends StatelessWidget {
  const SuperheroCard({
    super.key,
    required this.superhero,
    this.extraOnTap,
    this.isDeleted = false,
    this.onDeleted,
  });

  final BasicHeroModel superhero;
  final Function()? extraOnTap;
  final bool isDeleted;
  final Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        extraOnTap?.call();
        Get.to(SuperheroesDetailsScreen(hero: superhero));
        final box = Hive.box("last-heroes");
        await Future.delayed(100.milliseconds);
        await box.delete(superhero.id);
        box.put(superhero.id, superhero.toJson());
      },
      child: Stack(
        children: [
          Hero(tag: "herocard-${superhero.id}", child: CustomNetworkImage(url: superhero.url)),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 56.h,
                decoration: BoxDecoration(
                  color: CColors.backgroundcolor.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    superhero.name,
                    style: Styles.title.copyWith(color: CColors.white, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ),
          if (isDeleted)
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: CustomIconButton(
                    onTap: onDeleted,
                    backgroundColor: CColors.foregroundBlack.withOpacity(0.7),
                    icon: const Icon(
                      Ionicons.trash,
                      color: CColors.textColor,
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
