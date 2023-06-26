import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_ink_well.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';

class SuperheroCard extends StatelessWidget {
  const SuperheroCard({super.key, required this.superhero, this.onTap});

  final SuperheroModel superhero;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Stack(
        children: [
          CustomNetworkImage(url: superhero.image.url),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 56.h,
                decoration: BoxDecoration(
                  color: CColors.textColor.withOpacity(0.6),
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
        ],
      ),
    );
  }
}
