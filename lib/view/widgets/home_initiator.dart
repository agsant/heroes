
import 'dart:developer';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroes/config/constants.dart';
import 'package:heroes/services/api_response.dart';
import 'package:heroes/services/api_service.dart';
import 'package:heroes/model/hero_model.dart';
import 'package:heroes/view/screens/detail_screen.dart';
import 'package:heroes/viewmodel/hero_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeInitiator extends StatefulWidget{

  @override
  _HomeInitiatorState createState() => _HomeInitiatorState();
}

class _HomeInitiatorState extends State<HomeInitiator> {


  @override
  void initState() {
    super.initState();
    Provider.of<HeroViewModel>(context, listen: false).fetchHeroes("initiator");
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HeroViewModel>(context);
    List<HeroModel> heroList = vm.filteredHeroes;

    Widget getInitiatorHeroes(BuildContext context, ApiResponse apiResponse){

      switch (apiResponse.status) {
        case Status.LOADING:
          return Center(child: CircularProgressIndicator());
        case Status.INITIAL:
          return Center(child: CircularProgressIndicator());
        case Status.COMPLETED:
          return Scaffold(
            body: Container(
              color: Constants.colorPrimary,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: heroList.length,
                  itemBuilder: (BuildContext context, int index){
                    HeroModel heroModel = heroList[index];

                    log("Scaffold gridview: ${APIService().baseImageURL+heroModel.img}", name: "all heroes");

                    return Container(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailScreen(hero: heroModel)),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: Constants.colorPrimaryDark,
                            elevation: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 2/1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: FadeInImage.memoryNetwork(
                                      image: APIService().baseImageURL+heroModel.img,
                                      placeholder: kTransparentImage,
                                      imageErrorBuilder: (context, url, error) => Center(child: new Text("(No Image)", style: TextStyle(color: Colors.grey),),),
                                      fit: BoxFit.fitWidth,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 4.0),
                                  child: Text(
                                    heroModel.localizedName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Regular'
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
                                  child: Text(
                                    heroModel.roles!.join(", "),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontFamily: 'Regular'
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 3.0,
                                          height: 10.0,
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              color: heroModel.primaryAttr.toLowerCase() == "agi"? Constants.colorGreen :
                                              heroModel.primaryAttr.toLowerCase() == "int"? Constants.colorBlue : Constants.colorRed,
                                              boxShadow: [
                                                BoxShadow(spreadRadius: 2)
                                              ]
                                          ),
                                        ),
                                        Text(
                                          StringUtils.capitalize(heroModel.primaryAttr),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontFamily: 'Regular'
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                        )
                    );
                  }),
            ),
          );

        case Status.ERROR:
          return Center(
            child: Column(
              children: <Widget>[
                Text(apiResponse.message.toString())
              ],
            ),
          );
      }
    }

    ApiResponse apiResponse = Provider.of<HeroViewModel>(context).response;

    return getInitiatorHeroes(context, apiResponse);
  }
}