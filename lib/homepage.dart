import 'package:flutter/material.dart';
import 'package:newsapp/models.dart/NewsModle.dart';
import 'package:newsapp/secondpage.dart';
import 'package:newsapp/services.dart/catogary.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<NewsModle> articles = [];

  getNews() async {
    Newsapi newsapi = Newsapi();
    await newsapi.getNews();
    articles = newsapi.dataStore;
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 106, 169),
        title: Center(child: Text('News App')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: articles.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Secondpage()));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Image.network(
                          article.urlToImage!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(article.title!, style: const TextStyle()
                            // fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                        const Divider(
                          thickness: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
