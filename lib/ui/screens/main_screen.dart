import 'package:flutter/material.dart';
import 'package:help_your_city/providers/bottom_nav_bar_notifier.dart';
import 'package:help_your_city/providers/citizens_notifier.dart';
import 'package:help_your_city/providers/city_notifier.dart';
import 'package:help_your_city/providers/events_notifier.dart';
import 'package:help_your_city/providers/shops_notifier.dart';
import 'package:help_your_city/ui/screens/home_mobile.dart';
import 'package:help_your_city/ui/screens/wide_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String _title = 'Help Your City!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => BottomNavBarNotifier(),
            ),
            ChangeNotifierProvider(
              create: (context) => CityNotifier(),
            ),
            ChangeNotifierProvider(
              create: (context) => CitizensNotifier(),
            ),
            ChangeNotifierProvider(
              create: (context) => EventsNotifier(),
            ),
            ChangeNotifierProvider(
              create: (context) => ShopsNotifier(),
            ),
          ],
          child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints constraints) {
            if (constraints.maxWidth < 700) {
              return const HomeMobile();
            } else {
              return const WideScreen();
            }
          })),
    );
  }
}
