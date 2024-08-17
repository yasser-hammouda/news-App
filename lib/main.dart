import 'package:flutter/material.dart';
import 'package:news_app/home/home_screen.dart';
import 'package:news_app/home/news/news_details.dart';
import 'package:news_app/my_theme_data.dart';
import 'package:news_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MultiProvider(
      providers:[
      ChangeNotifierProvider(create: (context) => AppConfigProvider()),
      ],
      child : MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      theme: MyThemeData.lightTheme,
      routes: {
    HomeScreen.routeName : (context)=> HomeScreen(),
        //NewsDetails.routeName : (context)=> NewsDetails(n),
    },
      // locale: Locale(provider.appLanguage),
      // title: 'Localizations Sample App',
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

