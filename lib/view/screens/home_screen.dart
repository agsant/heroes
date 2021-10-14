
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroes/config/constants.dart';
import 'package:heroes/services/api_response.dart';
import 'package:heroes/view/widgets/home_all_heroes.dart';
import 'package:heroes/view/widgets/home_disabler.dart';
import 'package:heroes/view/widgets/home_escape.dart';
import 'package:heroes/view/widgets/home_initiator.dart';
import 'package:heroes/viewmodel/hero_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    Provider.of<HeroViewModel>(context, listen: false).fetchAllHeroes();
    controller = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<HeroViewModel>(context, listen: false).fetchAllHeroes();
    }
  }

  @override
  Widget build(BuildContext context) {

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result != ConnectivityResult.none) {
        Provider.of<HeroViewModel>(context, listen: false).fetchAllHeroes();
      }
    });

    Widget getHeroesWidget(BuildContext context, ApiResponse apiResponse){

      switch (apiResponse.status) {
        case Status.LOADING:
          return Scaffold(
              appBar: new AppBar(
                systemOverlayStyle:SystemUiOverlayStyle.light,
                backgroundColor: Constants.colorPrimaryDark,
                title: Align(alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("lib/images/dota_logo.png"), height: 20, fit: BoxFit.fitHeight,),
                      Text("  D O T A")
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Constants.colorPrimary,
                child: Center(child: CircularProgressIndicator()),
              )
          );
        case Status.COMPLETED:
          return Scaffold(
            appBar: new AppBar(
              systemOverlayStyle:SystemUiOverlayStyle.light,
              backgroundColor: Constants.colorPrimaryDark,
              title: Align(alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("lib/images/dota_logo.png"), height: 20, fit: BoxFit.fitHeight,),
                    Text("  D O T A")
                  ],
                ),
              ),
              bottom: new TabBar(
                  controller: controller,
                  indicatorColor: Constants.colorTabLine,
                  tabs: <Widget>[
                    new Tab(text: "All Heroes"),
                    new Tab(text: "Disabler",),
                    new Tab(text: "Initiator",),
                    new Tab(text: "Escape",),
                  ]
              ),
            ),
            body: new TabBarView(
              controller: controller,
              children: <Widget>[
                new HomeAllHeroes(),
                new HomeDisabler(),
                new HomeInitiator(),
                new HomeEscape()
              ],
            ),
          );
        case Status.ERROR:
          return Scaffold(
              appBar: new AppBar(
                systemOverlayStyle:SystemUiOverlayStyle.light,
                backgroundColor: Constants.colorPrimaryDark,
                title: Align(alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("lib/images/dota_logo.png"), height: 20, fit: BoxFit.fitHeight,),
                      Text("  D O T A")
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Constants.colorPrimary,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 140.0,
                      ),
                      Text("Error", style: TextStyle(color: Constants.colorWhite, fontSize: 28, fontWeight: FontWeight.bold),),
                      Text(apiResponse.message.toString(), style: TextStyle(color: Constants.colorWhite, fontSize: 20),),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 30,
                          width: 150,
                          child: TextButton(
                              onPressed: (){Provider.of<HeroViewModel>(context, listen: false).fetchAllHeroes();},
                              child: Text("Retry", style: TextStyle(color: Constants.colorWhite),),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Constants.colorPrimaryDark),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      )
                                  )
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        case Status.INITIAL:
          return Scaffold(
            appBar: new AppBar(
              systemOverlayStyle:SystemUiOverlayStyle.light,
              backgroundColor: Constants.colorPrimaryDark,
              title: Align(alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("lib/images/dota_logo.png"), height: 20, fit: BoxFit.fitHeight,),
                    Text("  D O T A")
                  ],
                ),
              ),
            ),
            body: Container(
              color: Constants.colorPrimary,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(apiResponse.message.toString(), style: TextStyle(color: Constants.colorWhite, fontSize: 20),),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 30,
                        width: 150,
                        child: TextButton(
                            onPressed: (){Provider.of<HeroViewModel>(context, listen: false).fetchAllHeroes();},
                            child: Text("Continue", style: TextStyle(color: Constants.colorWhite),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Constants.colorPrimaryDark),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                  )
                              )
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          );
      }
    }
    ApiResponse apiResponse = Provider.of<HeroViewModel>(context).response;

    return getHeroesWidget(context, apiResponse);
  }
}