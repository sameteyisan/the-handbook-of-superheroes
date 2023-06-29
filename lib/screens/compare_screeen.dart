import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/controllers/compare_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/extentions.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/center_loading.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';

class ComprateScreen extends StatelessWidget {
  const ComprateScreen({super.key, required this.heros});
  final List<BasicHeroModel> heros;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompareController(heros));

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Comparison Status").animate().flip(delay: 100.ms),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: heros
                  .asMap()
                  .entries
                  .map((kv) => Column(
                        children: [
                          SuperheroCard(
                            superhero: kv.value,
                            urlSize: Get.width * 0.5,
                            touchable: false,
                          )
                              .animate()
                              .slideX(begin: kv.key % 2 == 0 ? -3 : 3, delay: 200.ms)
                              .shake(delay: 600.ms)
                        ],
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => controller.isLoading.value
                ? const CenterLoading()
                : Column(
                    children: controller.powerstats.first.toMap().entries.map(
                      (kv) {
                        final firstKey = controller.powerstats[0].toMap()[kv.key];
                        final secondKey = controller.powerstats[1].toMap()[kv.key];
                        String winner = "";
                        String winnerUrl = "";
                        String score = "";

                        if (firstKey != "null" && secondKey != "null") {
                          final first = int.parse(firstKey);
                          final second = int.parse(secondKey);
                          (winner, winnerUrl, score) = controller.getData(first, second);
                        } else {
                          winner = "Unknown";
                        }

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                CColors.foregroundBlack,
                                CColors.foregroundBlack.withOpacity(0.6),
                                CColors.foregroundBlack.withOpacity(0.4),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: kv.key.formatKey,
                                        style: Styles.title.copyWith(color: CColors.subtitleColor),
                                        children: [
                                          const TextSpan(
                                            text: " - ",
                                            style: TextStyle(
                                              color: CColors.iconColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: winner,
                                            style: TextStyle(
                                              color: CColors.textColor,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.4,
                                              fontSize: 17.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            text: score,
                                            style: TextStyle(
                                              letterSpacing: 1.4,
                                              fontSize: 17.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (winnerUrl.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: CustomNetworkImage(
                                        url: winnerUrl,
                                        size: 40,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35.w,
                                    child: Text(firstKey == "null" ? "??" : firstKey,
                                        style: Styles.subtitle),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            activeTrackColor: Const.powerstatColors[kv.key],
                                          ),
                                          child: RangeSlider(
                                            min: 0,
                                            max: 200,
                                            values: RangeValues(
                                              firstKey == "null"
                                                  ? 100
                                                  : (100 - double.parse(firstKey)),
                                              secondKey == "null"
                                                  ? 100
                                                  : (100 + double.parse(secondKey)),
                                            ),
                                            onChanged: (_) {},
                                          ).animate().flip(delay: 800.ms),
                                        ),
                                        Center(
                                          child: Container(
                                            width: 5,
                                            height: 10,
                                            color: CColors.backgroundcolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35.w,
                                    child: Text(
                                      secondKey == "null" ? "??" : secondKey,
                                      style: Styles.subtitle,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ).animate().flip(delay: 300.ms);
                      },
                    ).toList(),
                  ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
