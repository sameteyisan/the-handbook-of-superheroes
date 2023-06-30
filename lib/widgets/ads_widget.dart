import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key, required this.bannerAd});
  final BannerAd bannerAd;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: CColors.backgroundcolor,
        width: bannerAd.size.width.toDouble(),
        height: bannerAd.size.height.toDouble(),
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
