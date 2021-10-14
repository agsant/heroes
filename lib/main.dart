import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroes/viewmodel/hero_view_model.dart';
import 'package:provider/provider.dart';

import 'config/constants.dart';
import 'config/navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HeroHomeApp());
}

class HeroHomeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HeroViewModel(),),
      ],
      child: MaterialApp(debugShowCheckedModeBanner
        : true,
        title: 'DOTA!',
        initialRoute: '/',
        routes: Navigation.routes,
        theme: ThemeData(
          primaryColor: Constants.colorPrimary,
          accentColor: Constants.colorPrimary,
          appBarTheme: AppBarTheme(systemOverlayStyle:
          SystemUiOverlayStyle.light) ,
        ),
      ),
    );
  }
}
