import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/models/fake_response.dart';

class MovieListProvider extends ChangeNotifier {
  final BuildContext context;
  MovieListProvider({required this.context});
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Response> responseList = [];

  addMovie(Response response) async {
    responseList.add(response);
    print("Movie Added");
    notifyListeners();
    print("Movie List Length ${responseList.length}");

    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey("favorite")) {}
  }

  updateFavorite(int id, bool isFavorite) async {
    int index = responseList.indexWhere((element) => element.id == id);
    responseList.elementAt(index).isFavourite = isFavorite;
    print("Movie List Length ${responseList.length}");

    print("Updated Favorite to $isFavorite at $index");

    await updateFavoritePref();

    notifyListeners();
  }

  getFavoriteList() {
    return responseList.where((element) => element.isFavourite).toList();
  }

  List<Response> searchMovie(String name) {
    return responseList
        .where((element) => element.name.toLowerCase().contains(name))
        .toList();
  }

  void addList() {
    addMovie(
      Response(0, "GOLD",
          "https://static.tvmaze.com/uploads/images/original_untouched/84/211238.jpg"),
    );
    addMovie(
      Response(1, "Gold Rush",
          "https://static.tvmaze.com/uploads/images/original_untouched/244/610985.jpg"),
    );
    addMovie(
      Response(2, "Attic Gold",
          "https://static.tvmaze.com/uploads/images/original_untouched/16/41290.jpg"),
    );
    addMovie(
      Response(3, "White Gold",
          "https://static.tvmaze.com/uploads/images/original_untouched/113/283528.jpg"),
    );
    addMovie(
      Response(4, "Backroad Gold",
          "https://static.tvmaze.com/uploads/images/original_untouched/93/233881.jpg"),
    );
    addMovie(
      Response(5, "Gold Digger",
          "https://static.tvmaze.com/uploads/images/original_untouched/218/546082.jpg"),
    );
    addMovie(
      Response(6, "Yukon Gold",
          "https://static.tvmaze.com/uploads/images/original_untouched/20/51711.jpg"),
    );
    addMovie(
      Response(7, "Hitler's Gold",
          "https://static.tvmaze.com/uploads/images/original_untouched/279/698792.jpg"),
    );
    addMovie(
      Response(8, "Gold Town",
          "https://static.tvmaze.com/uploads/images/original_untouched/300/750242.jpg"),
    );
  }

  Future<void> updateFavoritePref() async {
    final SharedPreferences prefs = await _prefs;
    List<Response> favList = getFavoriteList();
    List<String> indexList = [];
    for (Response res in favList) {
      indexList.add(res.id.toString());
    }
    prefs.setStringList("favorite", indexList);
  }
}
/*
movieList
categories
cast&directors
seriesList
*/
