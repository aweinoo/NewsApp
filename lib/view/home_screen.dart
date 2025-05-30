import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/categories_new_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/view/categories_screen.dart';
import 'package:newsapp/view/news_detail_screen.dart';
import 'package:newsapp/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// the-huffington-post
// the-times-of-india
// bbc-news
// bleachers-report
// australian-financial-review
// bloomberg
// buzzfeed
// cnn
// la-repubblica
// medical-news-today

enum FilterList {
  bbcNews,
  thetimesofindia,
  cnn,
  bleacherReport,
  theHuffingtonPost,
  australianFinancialReview,
  bloomberg,
  buzzfeed,
  laRepubblica,
  medicalNewsToday,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('EEE, M/d/y');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesScreen()),
            );
          },
          icon: Image.asset('images/category_icon.png', height: 20, width: 20),
        ),
        title: Center(
          child: Text(
            'News',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert, color: Colors.black),

            onSelected: (FilterList item) {
              if (FilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.cnn.name == item.name) {
                name = 'cnn';
              }
              if (FilterList.theHuffingtonPost.name == item.name) {
                name = 'the-huffington-post';
              }
              if (FilterList.thetimesofindia.name == item.name) {
                name = 'the-times-of-india';
              }
              if (FilterList.bleacherReport.name == item.name) {
                name = 'bleacher-report';
              }
              if (FilterList.australianFinancialReview.name == item.name) {
                name = 'australian-financial-review';
              }
              if (FilterList.bloomberg.name == item.name) {
                name = 'bloomberg';
              }
              if (FilterList.buzzfeed.name == item.name) {
                name = 'buzzfeed';
              }
              if (FilterList.laRepubblica.name == item.name) {
                name = 'la-repubblica';
              }
              if (FilterList.medicalNewsToday.name == item.name) {
                name = 'medical-news-today';
              }

              setState(() {
                selectedMenu = item;
              });
            },

            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<FilterList>>[
                  PopupMenuItem<FilterList>(
                    value: FilterList.bbcNews,
                    child: Text('BBC News'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.cnn,
                    child: Text('CNN'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.theHuffingtonPost,
                    child: Text('The Huffington Post'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.thetimesofindia,
                    child: Text('The Times of India'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.bleacherReport,
                    child: Text('Bleacher Report'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.australianFinancialReview,
                    child: Text('Australian Financial Report'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.bloomberg,
                    child: Text('BloomBerg'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.buzzfeed,
                    child: Text('Buzzfeed'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.laRepubblica,
                    child: Text('la Repubblica'),
                  ),
                  PopupMenuItem<FilterList>(
                    value: FilterList.medicalNewsToday,
                    child: Text('Medical News Today'),
                  ),
                ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(size: 50, color: Colors.blue),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => NewsDetailsScreen(
                                    newsImage:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .urlToImage
                                            .toString(),
                                    newsTitle:
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                    newsDate:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .publishedAt
                                            .toString(),
                                    author:
                                        snapshot.data!.articles![index].author
                                            .toString(),
                                    description:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .description
                                            .toString(),
                                    content:
                                        snapshot.data!.articles![index].content
                                            .toString(),
                                    source:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .source!
                                            .name
                                            .toString(),
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * .02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .urlToImage
                                            .toString(),
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) =>
                                            Container(child: spinKit2),
                                    errorWidget:
                                        (context, url, error) => Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(15),
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!
                                                .articles![index]
                                                .title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsModel('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(size: 50, color: Colors.blue),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl:
                                    snapshot.data!.articles![index].urlToImage
                                        .toString(),
                                fit: BoxFit.cover,
                                height: height * 0.18,
                                width: width * .3,
                                placeholder:
                                    (context, url) =>
                                        Container(child: spinKit2),
                                errorWidget:
                                    (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                height: height * 0.18,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot
                                              .data!
                                              .articles![index]
                                              .source!
                                              .name
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(color: Colors.amber, size: 50);
