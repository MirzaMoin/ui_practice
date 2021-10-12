import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/screens/category_list.dart';

import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController headerPageController;
  @override
  void initState() {
    super.initState();
    headerPageController = new PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (headerPageController.hasClients) {
        headerPageController.nextPage(
            duration: Duration(seconds: 1), curve: Curves.easeIn);
        if (headerPageController.page == ResponseData.length - 1) {
          headerPageController.animateToPage(0,
              duration: Duration(seconds: 1), curve: Curves.easeIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: ListView.builder(
              shrinkWrap: false,
              itemCount: 4,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return index == 0
                    ? getHeader()
                    : index == 1
                        ? getCategories()
                        : getContent();
              }),
        ),
      ),
    );
  }

  Widget getHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          PageView.builder(
              controller: headerPageController,
              physics: BouncingScrollPhysics(),
              itemCount: ResponseData.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.transparent,
                        child: Image.network(
                          ResponseData.elementAt(index).imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
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
                    Positioned(
                        bottom: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${ResponseData.elementAt(index).name}",
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
                        )),
                  ],
                );
              }),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Padding(
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
                            color: Color(0xffefe2f6),
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
                            color: Color(0xffefe2f6),
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
                            "assets/icons/ic_more.png",
                            width: 20,
                            height: 20,
                            color: Color(0xffefe2f6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getContent() {
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
                  "Continue watching",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily),
                ),
                Text(
                  "See more",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily),
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
                  itemCount: ResponseData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    ResponseData.elementAt(index))));
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
                                      ResponseData.elementAt(index).imageUrl,
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
                                        "${ResponseData.elementAt(index).name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .fontFamily),
                                      ),
                                      Text(
                                        "2020",
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

  Widget getCategories() {
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
                  itemCount: CategoriesList.length,
                  itemBuilder: (context, index) {
                    Categories category = CategoriesList.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        /*       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(index)));*/
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
}
