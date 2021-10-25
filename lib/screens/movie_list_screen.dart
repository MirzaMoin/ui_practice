import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/models/genres_model.dart';
import 'package:ui_practice/models/movie_model.dart';
import 'package:ui_practice/models/response_data.dart';
import 'package:ui_practice/models/response_model.dart';
import 'package:ui_practice/providers/movie_list_provider.dart';
import 'package:ui_practice/screens/login_screen.dart';
import 'package:ui_practice/screens/movie_details_screen.dart';
import 'package:ui_practice/services/http_service.dart';

class MovieListScreen extends StatefulWidget {
  final GenresModel? category;
  const MovieListScreen({this.category, Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  HttpService httpService = new HttpService();
  bool isLogin = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLoadedMovies();
    loadData();

    /*   Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            top: 45,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.category!.name}",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(child:
                  Consumer<MovieListProvider>(builder: (context, provider, _) {
                List<MovieModel> movielist = [];

                /*if (provider.categoryMovieList.length == 0) {
                  for (MovieModel m in provider.allMovieList) {
                    for (GenresModel g in m.genres!) {
                      if (g.categoryId == widget.category!.categoryId) {
                        int i = movielist.indexWhere(
                            (element) => element.movieId == m.movieId);

                        if (i == -1) {
                          movielist.add(m);
                        }
                      }
                    }
                  }
                  provider.categoryMovieList.clear();
                  provider.categoryMovieList.addAll(movielist.toList());
                }*/

                List<MovieModel> movie = provider.categoryMovieList;
                return isLoading
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Shimmer.fromColors(
                          baseColor: Theme.of(context).accentColor,
                          highlightColor:
                              Theme.of(context).accentColor.withOpacity(0.4),
                          enabled: isLoading,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 12,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                    ),
                                  ),
                                ],
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              mainAxisExtent: isLoading ? 180 : 200,
                              crossAxisSpacing: 10,
                            ),
                          ),
                        ),
                      )
                    : movie.length > 0
                        ? Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: AnimationLimiter(
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                physics: BouncingScrollPhysics(),
                                itemCount: movie.length,
                                itemBuilder: (context, index) {
                                  MovieModel mov = movie.elementAt(index);
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 3,
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      horizontalOffset: 0.0,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MovieDetailsScreen(
                                                            mov)));
                                          },
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  "${mov.thumbImage}",
                                                  fit: BoxFit.fill,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${mov.name}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              Theme.of(context)
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
                                },
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  mainAxisExtent: 200,
                                  crossAxisSpacing: 10,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: isLoading
                                ? Container()
                                : Text(
                                    "No item found",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 18),
                                  ));
              }))
            ],
          ),
        ));
  }

  Future<void> loadData() async {
    Provider.of<MovieListProvider>(context, listen: false)
        .categoryMovieList
        .clear();
    ResponseModel? responseData = await httpService.get(
        path: "getMovieListByGenres.php?genres=${widget.category!.categoryId}");
    if (responseData!.statusCode == 1) {
      print("Loaded Success");
      setState(() {
        isLoading = false;
      });
      ResponseData res = ResponseData.fromJson(responseData.responseData!);

      print("Length of cat in ${res.categoryMovieList!.length}");
      Provider.of<MovieListProvider>(context, listen: false)
          .setMovieListByCategory(res, widget.category!.categoryId);
    } else {
      setState(() {
        isLoading = false;
      });
      print("Something went wrong");
    }
  }

  void getLoadedMovies() {}
}
