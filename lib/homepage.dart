import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json/json.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PostList> data;
  @override
  void initState() {
    super.initState();
    Network network = Network(
        "https://raw.githubusercontent.com/vipuluthaiah/Movie-Api/master/movie.json");
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
       
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Text(
                "Movie App",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<PostList> snapshot) {
                List<Post> allPosts;
                if (snapshot.hasData) {
                  allPosts = snapshot.data.moviepost;
                  return Stack(
                    children: <Widget>[
                      Positioned(child: createListView(allPosts, context))
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Widget createListView(List<Post> data, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: 5),
        width: MediaQuery.of(context).size.width,
        // height: 130.0,

        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 5.0,
                ),
                child: Container(
                    height: 150,
                    child: Stack(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.only(left: 100, right: 10),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "${data[index].title}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Released :${data[index].rated} ",
                                          style: mainTextStyle(),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Rating : ${data[index].imdbRating} /10",
                                          style: mainTextStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.only(right: 80),
                                      child: Text(
                                          "Country :${data[index].country}",
                                          style: mainTextStyle()),
                                    )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 100),
                                      child: Text("${data[index].runtime}",
                                          style: mainTextStyle()),
                                    ),
                                    Text("${data[index].rated}",
                                        style: mainTextStyle())
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, left: 10),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage("${data[index].poster}"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }),
      ),
    );
  }
}

TextStyle mainTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}

class Network {
  final String url;
  Network(this.url);

  Future<PostList> loadPosts() async {
    final response = await get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get data");
    }
  }
}
