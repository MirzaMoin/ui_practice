import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:ui_practice/models/genres_model.dart';
import 'package:ui_practice/providers/movie_list_provider.dart';
import 'package:ui_practice/screens/download_video_screen.dart';
import 'package:ui_practice/screens/player_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'movie_details_screen.dart';
import 'movie_list_screen.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Consumer<MovieListProvider>(builder: (context, movieList, _) {
                return GridView.builder(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.12),
                  physics: BouncingScrollPhysics(),
                  itemCount: movieList.allGenresList.length,
                  itemBuilder: (context, index) {
                    GenresModel category =
                        movieList.allGenresList.elementAt(index);
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
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    mainAxisExtent: 80,
                    crossAxisSpacing: 13,
                  ),
                );
              }),
              getHeaderBack(),
            ],
          ),
        ));
  }

  Widget getHeaderBack() {
    return Positioned(
      top: 40,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/icons/ic_back_arrow.png",
                        width: 15,
                        height: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Categories",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
