import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/screens/superhero_details_screen.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';

class SuperheroTile extends StatelessWidget {
  const SuperheroTile({
    super.key,
    required this.superhero,
    this.onDeleted,
    required this.icon,
    this.iconColor,
  });
  final BasicHeroModel superhero;

  final Function()? onDeleted;
  final Widget icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(SuperheroesDetailsScreen(hero: superhero, isCard: false)),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: CColors.foregroundBlack,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            CustomNetworkImage(
              url: superhero.url,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                superhero.name,
                style: Styles.title.copyWith(letterSpacing: 1.5, fontSize: 17),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(onPressed: onDeleted, icon: icon),
            ),
          ],
        ),
      ),
    ).animate().flip(delay: 200.ms);
  }
}
