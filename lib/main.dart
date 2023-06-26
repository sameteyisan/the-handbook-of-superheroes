import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/screens/home_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLoading.instance
    ..errorWidget = const Icon(Ionicons.warning)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
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
          appBarTheme: AppBarTheme(
            backgroundColor: CColors.mainColor,
            titleTextStyle: Styles.title,
          ),
        ),
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
