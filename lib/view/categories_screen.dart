import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:khabar_dar/common/colors.dart';
import 'package:khabar_dar/view_model/categories_news_model.dart';
import 'package:khabar_dar/view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  String categoryName = 'General';
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  final formate = DateFormat('MM,dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          categoryName = categoriesList[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: categoryName == categoriesList[index]
                                  ? AppColors.colorBlack
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                child: Text(
                                  categoriesList[index].toString(),
                                  style: GoogleFonts.poppins(
                                      color:
                                          categoryName == categoriesList[index]
                                              ? Colors.white
                                              : AppColors.colorBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: height * .049,
              ),
              Expanded(
                child: FutureBuilder<CategoriesNewsModel>(
                    future: newsViewModel.fetchCategoriesNewsApi(categoryName),
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
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              String newsSource = snapshot
                                  .data!.articles![index].source!.name
                                  .toString();
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                          height: height * .18,
                                          width: width * .3,
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              )),
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: height * .18,
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                              overflow: TextOverflow.ellipsis,
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: AppColors.colorBlack,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                newsSource.length > 11
                                                    ? '${newsSource.substring(0, 10)}...'
                                                    : newsSource,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.colorRed,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                formate.format(dateTime),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
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
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
