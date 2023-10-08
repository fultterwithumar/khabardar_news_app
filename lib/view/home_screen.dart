import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:khabar_dar/common/colors.dart';
import 'package:khabar_dar/common/routes/routes_name.dart';
import 'package:khabar_dar/models/news_channel_headings_model.dart';
import 'package:khabar_dar/view/news_detail_screen.dart';
import 'package:khabar_dar/view_model/categories_news_model.dart';
import 'package:khabar_dar/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, abcNewsAu, alJazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  String name = 'bbc-news';
  final formate = DateFormat('MMMM dd, yyyy');
  final formateForVertical = DateFormat('MM,dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.categoriesScreen);
            },
            icon: Image.asset(
              'images/categoryicon.png',
              height: height * .06,
            ),
          ),
          title: Text(
            "Khabar Dar",
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedMenu,
                onSelected: (FilterList item) {
                  if (FilterList.bbcNews.name == item.name) {
                    name = 'bbc-news';
                  }
                  if (FilterList.aryNews.name == item.name) {
                    name = 'ary-news';
                  }
                  if (FilterList.abcNewsAu.name == item.name) {
                    name = 'abc-news-au';
                  }
                  setState(() {
                    selectedMenu = item;
                  });
                },
                color: Colors.white,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<FilterList>>[
                      const PopupMenuItem<FilterList>(
                          value: FilterList.bbcNews, child: Text('BBC News')),
                      const PopupMenuItem<FilterList>(
                          value: FilterList.aryNews, child: Text('ARY News')),
                      const PopupMenuItem<FilterList>(
                          value: FilterList.abcNewsAu,
                          child: Text('ABC News Au')),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .35,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModel>(
                  future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.colorBlack,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetailScreen(
                                              newsImage: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              newsTitle: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              content: snapshot.data!
                                                  .articles![index].content
                                                  .toString(),
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString(),
                                            )));
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * .6,
                                      width: width * .9,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: height * .02,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                  child: spinkit2,
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.error_outline,
                                                      color: Colors.red,
                                                    )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 17,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          padding: const EdgeInsets.all(12),
                                          height: height * .17,
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: width * 0.69,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: AppColors
                                                                    .colorRed,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Text(
                                                        formate
                                                            .format(dateTime),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: height * .65,
                width: width,
                child: FutureBuilder<CategoriesNewsModel>(
                    future: newsViewModel.fetchCategoriesNewsApi('General'),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitFadingCircle(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors.colorBlack,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              String newsSource = snapshot
                                  .data!.articles![index].source!.name
                                  .toString();
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailScreen(
                                                newsImage: snapshot.data!
                                                    .articles![index].urlToImage
                                                    .toString(),
                                                newsTitle: snapshot.data!
                                                    .articles![index].title
                                                    .toString(),
                                                newsDate: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .publishedAt
                                                    .toString(),
                                                author: snapshot.data!
                                                    .articles![index].author
                                                    .toString(),
                                                description: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .description
                                                    .toString(),
                                                content: snapshot.data!
                                                    .articles![index].content
                                                    .toString(),
                                                source: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                            height: height * .18,
                                            width: width * .3,
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                  child: Center(
                                                    child: SpinKitFadingCircle(
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .colorBlack,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.error_outline,
                                                      color: Colors.red,
                                                    )),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: height * .18,
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          children: [
                                            Text(
                                                overflow: TextOverflow.ellipsis,
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: AppColors.colorBlack,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  newsSource.length > 11
                                                      ? '${newsSource.substring(0, 10)}...'
                                                      : newsSource,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      color: AppColors.colorRed,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  formateForVertical
                                                      .format(dateTime),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}

const spinkit2 = SpinKitRotatingCircle(
  color: Color.fromARGB(255, 238, 155, 155),
  size: 50.0,
);
