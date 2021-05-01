import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:spraat/services/app.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'app/locator.dart';
import 'app/router.gr.dart' as R;
import 'services/app_localization.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(0, 81, 113, .1),
  100: Color.fromRGBO(0, 81, 113, .2),
  200: Color.fromRGBO(0, 81, 113, .3),
  300: Color.fromRGBO(0, 81, 113, .4),
  400: Color.fromRGBO(0, 81, 113, .5),
  500: Color.fromRGBO(0, 81, 113, .6),
  600: Color.fromRGBO(0, 81, 113, .7),
  700: Color.fromRGBO(0, 81, 113, .8),
  800: Color.fromRGBO(0, 81, 113, .9),
  900: Color.fromRGBO(0, 81, 113, 1),
};

// Main Page is core and not Auth
// When clicking "Submit request" if no user logged in redirect to login page
//todo:
//DONE Dark theme initial switch value i settings
//DONE cart should show login if user is not logged in
//DONE Offer page should show extra feature and doesnt show null values
//DONE Placing order page should allow the user to choose payment method (benefit disabled)

Future main() async {
  await ThemeManager.initialise();
  setUpLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppProvider(),
        builder: (context, snapshot) {
          var app = Provider.of<AppProvider>(context);
          return ThemeBuilder(
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Color.fromRGBO(0, 81, 113, 1.0),
                indicatorColor: Color.fromRGBO(0, 81, 113, 1.0),
                accentColor: Color.fromRGBO(0, 81, 113, 1.0),
                primarySwatch: MaterialColor(0xFF081113, color)),
            lightTheme: ThemeData(
                primarySwatch: MaterialColor(0xFF081113, color),
                accentColor: Color.fromRGBO(0, 81, 113, 1.0),
                primaryColor: Color.fromRGBO(0, 81, 113, 1.0),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Color.fromRGBO(0, 81, 113, 1.0))),
            builder: (context, regularTheme, darkTheme, themeMode) =>
                MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: app.locale,
              localeResolutionCallback: (locale, supportedLocales) {
                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                // If the locale of the device is not supported, use the first one
                // from the list (English, in this case).
                return supportedLocales.first;
              },
              supportedLocales: [
                const Locale('en', 'US'), // English
                const Locale('uz', 'BH'), // Hebrew
              ],
              title: 'Sppart',
              debugShowCheckedModeBanner: false,
              theme: regularTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              initialRoute: '/',
              onGenerateRoute: R.Router().onGenerateRoute,
              navigatorKey: locator<NavigationService>().navigatorKey,
            ),
          );
        });
  }
}
