
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:heroes/services/api_response.dart';
import 'package:heroes/services/api_service.dart';
import 'package:heroes/model/hero_model.dart';

class HeroViewModel with ChangeNotifier{

  ApiResponse apiResponse = ApiResponse.initial('Initial data');

  APIService apiService = new APIService();
  List<HeroModel> heroes = [];
  List<HeroModel> filteredHeroes = [];
  List<HeroModel> similarHeroes = [];

  ApiResponse get response {
    return apiResponse;
  }

  Future<void> fetchAllHeroes() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    apiResponse = ApiResponse.loading('Fetching heroes data');
    notifyListeners();

    if (connectivityResult != ConnectivityResult.none) {

      try {
        final results = await apiService.getHeroes();
        final jsonData = results as List;
        this.heroes =
            jsonData.map((tagJson) => HeroModel.fromJson(tagJson)).toList();

        apiResponse = ApiResponse.completed(this.heroes);
      } catch (e) {
        apiResponse = ApiResponse.error(e.toString());
        print(e);
      }
    }else{
      apiResponse = ApiResponse.error("No Internet Connection");
    }

    notifyListeners();
  }

  Future<void> fetchHeroes(String role) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    apiResponse = ApiResponse.loading('Fetching heroes data');
    notifyListeners();

    if (connectivityResult != ConnectivityResult.none) {

      try {
        if (role == "all")
          this.filteredHeroes = this.heroes;
        else
          this.filteredHeroes = this.heroes.where((
              element) =>
              element.roles!.join("").toLowerCase().contains(
                  role.toLowerCase())).toList();

        apiResponse = ApiResponse.completed(this.heroes);
      } catch (e) {
        apiResponse = ApiResponse.error(e.toString());
        print(e);
      }
    }else{
      apiResponse = ApiResponse.error("No Internet Connection");
    }

    notifyListeners();
  }

  Future<void> fetchSimilarHeroes(String attr, int currentId) async {
    final results =  await apiService.getHeroes();
    final jsonData = results as List;

    //filtering by primary attribute
    if(attr.toLowerCase() == "agi") {
      this.similarHeroes =
          jsonData.map((tagJson) => HeroModel.fromJson(tagJson)).where((
              element) =>
          element.primaryAttr.toLowerCase() == attr).where((element) => element.id != currentId).toList();
      this.similarHeroes.sort((b,a) => a.moveSpeed.compareTo(b.moveSpeed));
    }else if(attr.toLowerCase() == "str"){

      this.similarHeroes =
          jsonData.map((tagJson) => HeroModel.fromJson(tagJson)).where((
              element) =>
          element.primaryAttr.toLowerCase() == attr).where((element) => element.id != currentId).toList();
      this.similarHeroes.sort((b,a) => a.baseAttackMax.compareTo(b.baseAttackMax));
    }else if(attr.toLowerCase() == "int"){

      this.similarHeroes =
          jsonData.map((tagJson) => HeroModel.fromJson(tagJson)).where((
              element) =>
          element.primaryAttr.toLowerCase() == attr).where((element) => element.id != currentId).toList();
      this.similarHeroes.sort((b,a) => a.baseMana.compareTo(b.baseMana));
    }

    //Get top 3 of the lists
    int maxList = this.similarHeroes.length >=3? 3 : this.similarHeroes.length;
    this.similarHeroes = this.similarHeroes.sublist(0, maxList);

    notifyListeners();
  }
}