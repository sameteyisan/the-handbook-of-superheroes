import 'dart:io';
import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Helper {
  static void showToast(String msg) => EasyLoading.showToast(
        msg,
        toastPosition: EasyLoadingToastPosition.bottom,
      );

  static Future<void> showError(String msg) async {
    return await EasyLoading.showError(
      msg,
      dismissOnTap: true,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static String generateNonceNumber([int length = 6]) {
    const charset = '0123456789';
    final random = Random();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String get getBannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  static String get getInterstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  static BannerAd get getAd {
    final ads = <AdSize>[AdSize.banner, AdSize.largeBanner, AdSize.fullBanner];
    final rnd = Random().nextInt(ads.length);

    return BannerAd(
      adUnitId: getBannerAdUnitId,
      request: const AdRequest(),
      size: ads[rnd],
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, err) => ad.dispose(),
      ),
    )..load();
  }

  static Future<void> get showAd {
    return InterstitialAd.load(
        adUnitId: getInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdFailedToLoad: (LoadAdError error) {},
          onAdLoaded: (InterstitialAd ad) {
            ad.show();
          },
        ));
  }
}
