import 'package:flutter/material.dart';
import 'package:ui_practice/models/fake_response.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            top: 45,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Downloads",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: ResponseData.length,
                      itemBuilder: (context, index) {
                        /*   bool isDownloaded = true;
                        if (index % 2 == 0) {
                          isDownloaded = false;
                        }*/
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          height: MediaQuery.of(context).size.height * 0.13,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            ResponseData.elementAt(index)
                                                .imageUrl,
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                        ),
                                        Center(
                                            child: Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .backgroundColor
                                                        .withOpacity(0.6)),
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                  size: 15,
                                                )))
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ResponseData.elementAt(index).name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "2.5 GB 3h 2m",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0x3939416c)),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 17,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ],
                          ),

                          /*child: ListTile(
                            leading: Container(
                              height: 120,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 50,
                                  height: 60,
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        ResponseData.elementAt(index).imageUrl,
                                        fit: BoxFit.fill,
                                        width: 50,
                                        height: 60,
                                      ),
                                      Center(
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .backgroundColor
                                                      .withOpacity(0.6)),
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              )))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              ResponseData.elementAt(index).name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "2.5 GB 3h 2m",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0x3939416c)),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),*/
                        );
                      }))
            ],
          ),
        ));
  }
}
