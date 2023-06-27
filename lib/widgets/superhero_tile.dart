import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/screens/superhero_details_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';

class SuperheroTile extends StatelessWidget {
  const SuperheroTile({super.key, required this.superhero, this.onDeleted});
  final BasicHeroModel superhero;

  final Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(SuperheroesDetailsScreen(
        hero: superhero,
        isCard: false,
      )),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: CColors.foregroundBlack,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Hero(
              tag: "herotile-${superhero.id}",
              child: CustomNetworkImage(
                url: superhero.url,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                superhero.name,
                style: Styles.title.copyWith(
                  letterSpacing: 1.5,
                  fontSize: 17.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            IconButton(
              onPressed: onDeleted,
              icon: const Icon(
                Ionicons.close,
                color: CColors.subtitleColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
