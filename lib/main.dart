import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/firebase_options.dart';
import 'package:the_handbook_of_superheroes/screens/home_screen.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  MobileAds.instance.initialize();

  EasyLoading.instance
    ..errorWidget = Icon(Ionicons.warning, color: CColors.textColor, shadows: Const.shadows)
    ..indicatorType = EasyLoadingIndicatorType.chasingDots;

  await Hive.initFlutter();
  await Hive.openBox("favorites");
  await Hive.openBox("last-heroes");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "The Handbook of Superheroes",
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: CColors.backgroundcolor,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: CColors.foregroundBlack,
          titleTextStyle: Styles.title,
        ),
        sliderTheme: const SliderThemeData(
          overlayShape: RoundSliderThumbShape(enabledThumbRadius: 4, elevation: 0),
          inactiveTrackColor: CColors.sideColor,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
          thumbColor: Colors.transparent,
          rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 0.1, elevation: 0),
        ),
      ),
      // initialBinding: GlobalBindings(),
      home: const HomeScreen(),
      routes: const {},
      onGenerateRoute: (settings) => null,
      builder:
          (BuildContext context, Widget? child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: FlutterEasyLoading(child: Stack(children: [child!, const CompareWidget()])),
          ),
    );
  }
}
