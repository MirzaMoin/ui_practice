import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/models/genres_model.dart';
import 'package:ui_practice/models/movie_model.dart';
import 'package:ui_practice/models/response_data.dart';

class MovieListProvider extends ChangeNotifier {
  final BuildContext context;
  MovieListProvider({required this.context});
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Response> movieList = [];
  List<MovieModel> allMovieList = [];
  List<MovieModel> topMovieList = [];
  List<MovieModel> movieListLatest = [];
  List<GenresModel> generesList = [];
  List<GenresModel> allGenresList = [];

  setMovieList(ResponseData responseData) {
    topMovieList.addAll(responseData.topMovies!);
    movieListLatest.addAll(responseData.movieListLatest!);
    allMovieList.addAll(responseData.movieList!);
    generesList.addAll(responseData.genres!);
    allGenresList.addAll(responseData.totalCategory!);
    notifyListeners();
  }

  addMovie(Response response) async {
    movieList.add(response);
    print("Movie Added");
    notifyListeners();
    print("Movie List Length ${allMovieList.length}");

    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey("favorite")) {}
  }

  updateFavorite(int id, bool isFavorite) async {
    int index = movieList.indexWhere((element) => element.id == id);
    movieList.elementAt(index).isFavourite = isFavorite;
    print("Movie List Length ${allMovieList.length}");

    print("Updated Favorite to $isFavorite at $index");

    await updateFavoritePref();

    notifyListeners();
  }

  getFavoriteList() {
    return movieList.where((element) => element.isFavourite).toList();
  }

  List<Response> searchMovie(String name) {
    return movieList
        .where((element) => element.name.toLowerCase().contains(name))
        .toList();
  }

  void loadData() {
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
