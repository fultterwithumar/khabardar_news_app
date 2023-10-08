import 'package:flutter/material.dart';
import 'package:khabar_dar/common/routes/routes_name.dart';
import 'package:khabar_dar/view/categories_screen.dart';
import 'package:khabar_dar/view/home_screen.dart';
import 'package:khabar_dar/view/news_detail_screen.dart';
import 'package:khabar_dar/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.categoriesScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CategoriesScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Routes Defined"),
            ),
          );
        });
    }
  }
}
