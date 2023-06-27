import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/screens/superhero_details_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/delete_modal.dart';

class SuperheroTile extends StatelessWidget {
  const SuperheroTile({super.key, required this.superhero});
  final BasicHeroModel superhero;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => Get.to(SuperheroesDetailsScreen(hero: superhero)),
      child: Ink(
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
                style: Styles.title.copyWith(
                  letterSpacing: 1.5,
                  fontSize: 17.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            IconButton(
              onPressed: () async {
                final res = await DeleteModal.open();
                if (res != null) {
                  final box = Hive.box("last-heroes");
                  box.delete(superhero.id);
                }
              },
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
