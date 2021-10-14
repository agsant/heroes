
import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:heroes/config/constants.dart';
import 'package:heroes/model/hero_model.dart';
import 'package:heroes/services/api_service.dart';
import 'package:heroes/viewmodel/hero_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatefulWidget {
  HeroModel hero;

  DetailScreen({Key? key, required this.hero}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(hero: hero);
}

class _DetailScreenState extends State<DetailScreen> {

  HeroModel hero;
  _DetailScreenState({required this.hero});


  @override
  void initState() {
    super.initState();
    Provider.of<HeroViewModel>(context, listen: false).fetchSimilarHeroes(hero.primaryAttr, hero.id);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HeroViewModel>(context);
   List<HeroModel> heroList = vm.similarHeroes;

    return Scaffold(
        appBar: new AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Constants.colorPrimaryDark,
          title: Align(alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(hero.localizedName)
              ],
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          color: Constants.colorPrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: FadeInImage.memoryNetwork(
                  image: APIService().baseImageURL+hero.img,
                  placeholder: kTransparentImage,
                  imageErrorBuilder: (context, url, error) => Center(child: new Text("(No Image)", style: TextStyle(color: Colors.grey),),),
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
              Container(
                color: Constants.colorPrimaryDark,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
                  child: Text(
                    hero.roles!.join(", "),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Regular'
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: Constants.colorPrimaryDark,
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 16.0,left: 6.0, right: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget> [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4.0),
                                        child: Text("Type", style: TextStyle(fontSize: 10,color: Colors.grey),),
                                      ),
                                      Text(hero.attackType, style: TextStyle(fontSize: 16,color: Constants.colorWhite),)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4.0),
                                        child: Text("Max Atk", style: TextStyle(fontSize: 10,color: Colors.grey),),
                                      ),
                                      Text("${hero.baseAttackMin.toInt()} - ${hero.baseAttackMax.toInt()}", style: TextStyle(fontSize: 16,color: Constants.colorWhite),)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4.0),
                                        child: Text("Health", style: TextStyle(fontSize: 10,color: Colors.grey),),
                                      ),
                                      Text(hero.baseHealth.toInt().toString(), style: TextStyle(fontSize: 16,color: Constants.colorWhite),)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4.0),
                                        child: Text("MSPD", style: TextStyle(fontSize: 10,color: Colors.grey),),
                                      ),
                                      Text("${hero.moveSpeed.toInt()}", style: TextStyle(fontSize: 16,color: Constants.colorWhite),)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4.0),
                                        child: Text("Attr", style: TextStyle(fontSize: 10,color: Colors.grey),),
                                      ),
                                      Text(StringUtils.capitalize(hero.primaryAttr), style: TextStyle(fontSize: 16,color: Constants.colorWhite),)
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.0, top: 8.0,bottom: 4.0),
                          width: double.infinity,
                          child: Text("Similar Heroes", style: TextStyle(fontSize: 16,color: Colors.grey),),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: heroList.length,
                            itemBuilder: ( context, index){
                              HeroModel heroModel = heroList[index];

                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DetailScreen(hero: heroModel)),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  margin: EdgeInsets.only(bottom: 8.0),
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new NetworkImage(APIService().baseImageURL+heroModel.img),
                                      fit: BoxFit.fitWidth,
                                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(heroModel.localizedName,
                                        style: TextStyle(fontSize: 16,color: Colors.grey, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              );
                            }
                          )
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}
