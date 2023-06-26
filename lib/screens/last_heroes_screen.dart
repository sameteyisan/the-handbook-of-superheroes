import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_tile.dart';

class LastHeroesScreen extends StatelessWidget {
  const LastHeroesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Last Heroes you viewed"),
        actions: [
          IconButton(
            onPressed: () {
              final box = Hive.box("last-heroes");
              box.deleteAll(box.keys);
            },
            icon: const Icon(
              Ionicons.trash,
              color: CColors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: Hive.box("last-heroes").listenable(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Ionicons.eye_outline),
              const SizedBox(height: 16),
              Text(
                "The superheroes you last visited are displayed here.",
                style: Styles.title.copyWith(fontSize: 17.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          builder: (context, box, child) {
            if (box.isEmpty) {
              return child!;
            }
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              children: box.keys.map(
                (key) {
                  final superhero = BasicHeroModel.fromJson(box.get(key));

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SuperheroTile(superhero: superhero),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
