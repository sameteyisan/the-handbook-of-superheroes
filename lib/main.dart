import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/firebase_options.dart';
import 'package:the_handbook_of_superheroes/screens/home_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            centerTitle: true,
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
