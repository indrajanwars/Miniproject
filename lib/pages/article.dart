import 'package:flutter/material.dart';
import 'package:miniproject/pages/articledetail.dart';
import 'package:miniproject/pages/articlecreate.dart';
import 'package:miniproject/model/articlemodel.dart';
import 'package:miniproject/provider/articleprovider.dart';
import 'package:miniproject/style.dart';
import 'package:miniproject/widget/articlecard.dart';
import 'package:miniproject/widget/menu.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ArticleProvider _articleProvider;
  late List<Article> articles = [];
  late bool isLoading = true;

  @override
  void initState() {
    _articleProvider = new ArticleProvider();
    onGetListArticle(context, 1, "", "").then((jsonList) {
      print(jsonList);
      if (jsonList != null && jsonList is List<dynamic>) {
        setState(() {
          articles = jsonList.map((item) => Article.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        print("Error: Invalid JSON data format");
      }
    }).catchError((error) {
      print("Error: $error");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));
    } else {
      if (articles.isEmpty) {
        return Scaffold(
          backgroundColor: Styles.whiteblue,
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Image.asset(
              "assets/metrodata.png",
              width: 150,
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  print("menu");
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.closeEndDrawer();
                  } else {
                    scaffoldKey.currentState!.openEndDrawer();
                  }
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                color: Styles.black,
              )
            ],
          ),
          endDrawer: Menu(showProfileMenu: true),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Styles.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateArticlePage()));
              print('Tombol tambah ditekan!');
            },
            tooltip: 'Buat artikel Baru',
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Artikel Belum Tersedia",
                  style: TextStyle(fontSize: 48),
                  textAlign: TextAlign.center,
                ),
              )),
        );
      } else {
        return Scaffold(
          backgroundColor: Styles.whiteblue,
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Image.asset(
              "assets/metrodata.png",
              width: 150,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                color: Styles.black,
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.closeEndDrawer();
                    //close drawer, if drawer is open
                  } else {
                    scaffoldKey.currentState!.openEndDrawer();
                    //open drawer, if drawer is closed
                  }
                },
              )
            ],
          ),
          endDrawer: Menu(showProfileMenu: true),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Styles.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateArticlePage()));
              print('Tombol tambah ditekan!');
            },
            tooltip: 'Buat artikel Baru', // Teks tooltip saat FAB ditekan lama
            child: Icon(
              Icons.add,
              size: 40,
            ), // Ikon tambah
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Text(
                    "Artikel, Informasi, dan Promosi Metrodata Academy",
                    style: Styles.headerarticle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Dapatkan artikel dan pengetahuan terbaru di dunia Teknologi Informasi serta nikmati promo training, workshop, dan berbagai keuntungan lainnya dari Metrodata Academy",
                    style: Styles.subheaderTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleDetailPage(
                                  articleId: "${articles[0].id}",
                                )));
                  },
                  child: ArticleCard(
                    article: articles[0],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                      articleId: "${articles[1].id}",
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: ArticleCard(
                          article: articles[1], //ngambil data index ke 1
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                      articleId: "${articles[2].id}",
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: ArticleCard(
                          article: articles[2], //ngambil data index ke 2
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                      articleId: "${articles[1].id}",
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: ArticleCard(
                          article: articles[3], //ngambil data index ke 3
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                      articleId: "${articles[2].id}",
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: ArticleCard(
                          article: articles[4], //ngambil data index ke 4
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    }
  }

  onGetListArticle(
      BuildContext context, int page, String title, String category) async {
    dynamic result =
        await _articleProvider.getlistarticle(page, title, category);

    if (result != null && result['message'] == "Success") {
      print(result["data"]);
      return (result["data"]);
    } else {
      print("error123");
    }
  }
}
