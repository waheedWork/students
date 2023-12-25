import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/routes.dart';

import 'core/services/services.dart';
import 'initialbinding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        // Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'DZ'),
      child: MyApp(),
      // child: DevicePreview(
      //   builder: (context) =>  MyApp(),
      //   enabled: false,
      // ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'StudentApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(30, 129, 176, 1),
          foregroundColor: Colors.white,
        ),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color.fromRGBO(30, 129, 176, 1),
        fontFamily: 'Cairo',
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromRGBO(30, 129, 176, 1),
          elevation: 1,
        ),
        textTheme: const TextTheme(),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(30, 129, 176, 1),
          foregroundColor: Colors.white,
          elevation: 5,
          iconSize: 44,
        ),
      ),
      getPages: routes,
      initialBinding: InitialBinding(),
    );
  }
}
