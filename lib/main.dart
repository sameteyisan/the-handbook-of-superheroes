import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/firebase_options.dart';
import 'package:the_handbook_of_superheroes/screens/home_screen.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';

void main() async {
  Paint.enableDithering = true;
  Animate.restartOnHotReload = true;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  EasyLoading.instance
    ..errorWidget = Icon(
      Ionicons.warning,
      color: CColors.textColor,
      shadows: Const.shadows,
    )
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
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const HomeScreen(),
      builder: (context, child) => GetMaterialApp(
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
            )),
        // initialBinding: GlobalBindings(),
        home: child,
        routes: const {},
        onGenerateRoute: (settings) => null,
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: FlutterEasyLoading(child: child),
        ),
      ),
    );
  }
}
