import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/models/genres_model.dart';
import 'package:ui_practice/models/movie_model.dart';
import 'package:ui_practice/providers/movie_list_provider.dart';
import 'package:ui_practice/screens/category_list.dart';
import 'package:ui_practice/screens/movie_list_screen.dart';
import 'package:ui_practice/utils/utils.dart';

import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController headerPageController;
  List<MovieModel> topMovieList = [];
  @override
  void initState() {
    super.initState();
    topMovieList =
        Provider.of<MovieListProvider>(context, listen: false).topMovieList;
    headerPageController = new PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (headerPageController.hasClients) {
        headerPageController.nextPage(
            duration: Duration(seconds: 1), curve: Curves.easeIn);
        if (headerPageController.page == topMovieList.length - 1) {
          headerPageController.animateToPage(0,
              duration: Duration(seconds: 1), curve: Curves.easeIn);
        }
      }
    });

    /*  Future.delayed(Duration(seconds: 2), () {
      Utils.showUpdateDialog(
          context: context,
          title: "Update App",
          description: "Update app and get best features ");
    });*/
  }

  @override
  Widget build(BuildContext context) {
    print("Callllled");
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Consumer<MovieListProvider>(builder: (context, movieList, _) {
            return ListView.builder(
                shrinkWrap: false,
                itemCount: movieList.generesList.length + 3,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  GenresModel genres = new GenresModel();
                  List<MovieModel> movielist = [];
                  if (index > 2) {
                    genres = movieList.generesList.elementAt(index - 3);

                    for (MovieModel m in movieList.allMovieList) {
                      for (GenresModel g in m.genres!) {
                        if (g.name == genres.name) {
                          int i = movielist.indexWhere(
                              (element) => element.movieId == m.movieId);

                          if (i == -1) {
                            movielist.add(m);
                          }
                        }
                      }
                    }

                    print("Length of ${movielist.length}");
                  }

                  return index == 0
                      ? getHeader()
                      : index == 1
                          ? getCategories(movieList.allGenresList)
                          : index == 2
                              ? getLatest(movieList.movieListLatest)
                              : getContent(genres, movielist);
                });
          }),
        ),
      ),
    );
  }

  int currentPage = 0;
  Widget getHeader() {
    return Consumer<MovieListProvider>(builder: (context, topMovies, _) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.30,
        child: Stack(
          children: [
            PageView.builder(
                controller: headerPageController,
                physics: BouncingScrollPhysics(),
                itemCount: topMovies.topMovieList.length,
                itemBuilder: (context, index) {
                  currentPage = index;

                  MovieModel movie = topMovies.topMovieList.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MovieDetailsScreen(movie)));
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: Colors.transparent,
                            child: Image.network(
                              "${movie.bannerImage}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      blurRadius: 100.0,
                                      spreadRadius: 20),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.001),
                                    Theme.of(context).backgroundColor
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                          ),
                        ),
                        /* Positioned(
                            bottom: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${movie.name}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .fontFamily),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )),*/
                      ],
                    ),
                  );
                }),
            /*   Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).buttonColor,
                              blurRadius: 10,
                              offset: Offset(1, 2),
                            ),
                          ],
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(bottom: 20),
                      child: MaterialButton(
                        elevation: 0,
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              "Play Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    */ /*Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              "assets/icons/ic_heart.png",
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              "assets/icons/ic_download.png",
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          */ /* */ /* GestureDetector(
                            onTap: () {
                              print("Current Page $currentPage");

                              showWatchedDialog(
                                  context: context,
                                  title: "Did you already watched?",
                                  description:
                                      "Did you already watched ${topMovies.topMovieList.elementAt(currentPage).name!}?",
                                  onPositiveClick: () {
                                    Provider.of<MovieListProvider>(context,
                                            listen: false)
                                        .updateWatchedList(
                                            topMovies.topMovieList
                                                .elementAt(currentPage)
                                                .movieId!,
                                            true);
                                    Navigator.pop(context);
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                "assets/icons/ic_watched.png",
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),*/ /* */ /*
                        ],
                      ),
                    ),*/ /*
                  ],
                ),
              ),
            )*/
          ],
        ),
      );
    });
  }

  Widget getContent(GenresModel genres, List<MovieModel> movielist) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${genres.name}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MovieListScreen(
                                  category: genres,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "See more",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .headline1!
                              .fontFamily),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: movielist.length,
                  itemBuilder: (context, index) {
                    MovieModel movie = movielist.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(movie)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: SingleChildScrollView(
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      "${movie.thumbImage}",
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${movie.name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .fontFamily),
                                      ),
                                      Text(
                                        "${movie.year}",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .fontFamily),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget getCategories(List<GenresModel> allGenresList) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily:
                            Theme.of(context).textTheme.headline1!.fontFamily),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CategoryListScreen())),
                  child: Text(
                    "See more",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        fontFamily:
                            Theme.of(context).textTheme.headline1!.fontFamily),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      allGenresList.length > 15 ? 15 : allGenresList.length,
                  itemBuilder: (context, index) {
                    GenresModel category = allGenresList.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieListScreen(
                                      category: category,
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: SingleChildScrollView(
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${category.icon}"),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${category.name}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .fontFamily),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  static showWatchedDialog(
      {required BuildContext context,
      required String title,
      required String description,
      required Function onPositiveClick}) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Container(
          width: 500,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        content: Container(
          child: Text(
            "$description",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          MaterialButton(
            height: 40,
            color: Theme.of(context).backgroundColor,
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          MaterialButton(
            height: 40,
            color: Theme.of(context).backgroundColor,
            onPressed: () {
              onPositiveClick();
            },
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getLatest(List<MovieModel> movieListLatest) {
    print("Length of Latest ${movieListLatest.length}");
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Latest release",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieListScreen(
                                  isLatest: true,
                                )));
                  },
                  child: Text(
                    "See more",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        fontFamily:
                            Theme.of(context).textTheme.headline1!.fontFamily),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: movieListLatest.length,
                  itemBuilder: (context, index) {
                    MovieModel movie = movieListLatest.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(movie)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: SingleChildScrollView(
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      "${movie.thumbImage}",
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${movie.name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .fontFamily),
                                      ),
                                      Text(
                                        "${movie.year}",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .fontFamily),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
