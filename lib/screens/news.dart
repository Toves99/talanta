import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NewsPage> {
  Future<List<Article>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=careers&from=2024-02-28&sortBy=publishedAt&apiKey=7ff886137aac41ddae0ae841320963f5'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<Article> fetchedArticles = List<Article>.from(
          data['articles'].map((article) => Article.fromJson(article)));

      print("ARTICLES $fetchedArticles");

      return fetchedArticles;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_sharp),
              ),
              Spacer(),
              Text(
                'View Career News',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  color: const Color(0xfff566370),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer()
            ],
          ),
          FutureBuilder<List<Article>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Article> articles = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String formattedDate = DateFormat.yMMMMd().add_jm().format(
                        DateTime.parse(articles[index].publishedAt.toString()));
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          articles[index].title.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles[index].description.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Published at: $formattedDate',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Source: ${articles[index].sourceName}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: articles[index].urlToImage != null
                            ? Image.network(
                                articles[index].urlToImage!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : SizedBox.shrink(),
                        onTap: () {
                          _launchURL(articles[index].url.toString());
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}

class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? sourceName;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      sourceName: json['source']['name'],
    );
  }
}
