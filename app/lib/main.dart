import 'package:app/pages/page_404.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/routes/routes.dart' as routes;
import 'package:app/theme/theme.dart' as theme;
void main() async {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  final String route;
  MainPage({this.route = 'launch_page'});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        locale: Locale('en', 'US'),
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        title: "Jl My MKT",
        theme: theme.getApplicationTheme(),
        routes: routes.getApplicationRoutes(),
        initialRoute: 'launch_page',
    );
  }
}
