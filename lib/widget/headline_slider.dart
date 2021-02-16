import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/get_top_headlines_bloc.dart';
import 'package:news/element/error_element.dart';
import 'package:news/element/loader.dart';
import 'package:news/model/data_response.dart';
import 'package:news/model/news_response_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadLineSliderWidget extends StatefulWidget {
  @override
  _HeadLineSliderWidgetState createState() => _HeadLineSliderWidgetState();
}

class _HeadLineSliderWidgetState extends State<HeadLineSliderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopHeadlinesBloc..getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataResponse<NewsResponseEntity>>(
        stream: getTopHeadlinesBloc.subject,
        // ignore: missing_return
        builder: (context,
            AsyncSnapshot<DataResponse<NewsResponseEntity>> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.Success:
                return _buildHeadLineSlider(snapshot.data.res);

              case Status.Error:
                return buildErrorWidget(snapshot.error.toString());
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingWidget();
          } else if (snapshot.hasError) {
            buildErrorWidget(snapshot.error.toString());
          }

          //   if (snapshot.data.res !=){
          //     return _buildHeadLineSlider (snapshot.data);
          //   }else if (snapshot.hasError){
          //
          //   }else {
          //     return buildLoadingWidget();
          //   }
          //
          // }
        });
  }
}

Widget _buildHeadLineSlider(NewsResponseEntity data) {
  return Container(
    child: CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        height: 200,
        viewportFraction: 0.9,
      ),
      items: getExpenseSlider(data.articles),
    ),
  );
}

getExpenseSlider(List<NewsResponseArticle> articles) {
  return articles
      .map(
        (article) => GestureDetector(
          onTap: () {},
          child: Container(
            padding:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: article.urlToImage == null
                              ? Image.asset('assets/img/placeholder.jpg')
                              : NetworkImage(article.urlToImage))),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0)
                          ])),
                ),
                Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      width: 250.0,
                      child: Column(
                        children: [
                          Text(
                            article.title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          )
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child: Text(
                    article.source.name,
                    style: TextStyle(color: Colors.white54, fontSize: 9.0),
                  ),
                ),
                Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      article.source.name,
                      style: TextStyle(color: Colors.white54, fontSize: 9.0),
                    )),
                Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Text(
                      timeUntil(DateTime.parse(article.publishedAt)),
                      style: TextStyle(color: Colors.white54, fontSize: 9.0),
                    )),
              ],
            ),
          ),
        ),
      )
      .toList();
}

String timeUntil(DateTime date) {
  return timeago.format(date, allowFromNow: true, locale: 'en');
}
