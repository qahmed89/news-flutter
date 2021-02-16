import 'package:flutter/material.dart';
import 'package:news/bloc/get_hotnews_bloc.dart';
import 'package:news/element/error_element.dart';
import 'package:news/element/loader.dart';
import 'package:news/model/data_response.dart';
import 'package:news/model/news_response_entity.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news/style/theme.dart' as Style;

class HotNews extends StatefulWidget {
  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotNewsBloc..getHotNews();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataResponse<NewsResponseEntity>>(
        stream: getHotNewsBloc.subject,
        // ignore: missing_return
        builder: (context,
        AsyncSnapshot<DataResponse<NewsResponseEntity>> snapshot) {
      if (snapshot.hasData) {
        switch (snapshot.data.status) {
          case Status.Success:
            return _buildHotNewsWidget(snapshot.data.res);

          case Status.Error:
            return buildErrorWidget(snapshot.error.toString());
        }
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return buildLoadingWidget();
      } else if (snapshot.hasError) {
        buildErrorWidget(snapshot.error.toString());
      }

        });
  }
  Widget _buildHotNewsWidget(NewsResponseEntity res) {
    List<NewsResponseArticle> articles = res.articles;

    if (articles.isEmpty) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more news",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return Container(
        height: articles.length/2*210.0,
        padding: EdgeInsets.all(5.0),
        child: new GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DetailNews(
                  //           article: articles[index],
                  //         )));
                },
                child: Container(
                  width: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius:
                        5.0,
                        spreadRadius:
                        1.0,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: articles[index].urlToImage == null ? AssetImage("aseets/img/placeholder.jpg") : NetworkImage(articles[index].urlToImage),
                                  fit: BoxFit.cover
                              )
                          ),

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:10.0, right: 10.0, top: 15.0, bottom: 15.0),
                        child: Text(articles[index].title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.3,
                              fontSize: 15.0
                          ),),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: MediaQuery.of(context).size.width,
                            height: 1.0,
                            color: Colors.black12,

                          ),
                          Container(
                            width: MediaQuery.of(context).size.width /9,
                            height: 3.0,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              articles[index].source.name,
                              style: TextStyle(
                                  color: Style.Colors.mainColor,
                                  fontSize: 9.0),
                            ),
                            Text(
                              timeUntil(DateTime.parse(articles[index].publishedAt)),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 9.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

}

String timeUntil(DateTime date) {
  return timeago.format(date, allowFromNow: true, locale: 'en');
}



