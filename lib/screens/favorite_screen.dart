import 'package:flutter/material.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/screens/login_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isLogin = false;

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
                    "Favorite",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              isLogin
                  ? Expanded(
                      child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: ResponseData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  ResponseData.elementAt(index).imageUrl,
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 10,
                      ),
                    ))
                  : Expanded(
                      child: Center(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login to see favorite list",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
                            },
                            child: Text(
                              "Login Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )))
            ],
          ),
        ));
  }
}
