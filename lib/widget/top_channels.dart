import 'package:flutter/material.dart';
import 'package:news/bloc/get_sources_bloc.dart';
import 'package:news/element/error_element.dart';
import 'package:news/element/loader.dart';
import 'package:news/model/data_response.dart';
import 'package:news/model/news_response_entity.dart';
import 'package:news/model/sorces_resonse_entity.dart';

class TopChannelWidget extends StatefulWidget {
  @override
  _TopChannelWidgetState createState() => _TopChannelWidgetState();
}

class _TopChannelWidgetState extends State<TopChannelWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourcesBloc.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataResponse<SorcesResonseEntity>>(
        stream: getSourcesBloc.subject,
        // ignore: missing_return
        builder: (context,
            AsyncSnapshot<DataResponse<SorcesResonseEntity>> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.Success:
                return _buildTopChannels(snapshot.data.res);

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

  Widget _buildTopChannels(SorcesResonseEntity res) {
    List<SorcesResonseSource> soures = res.sources;
    if (soures.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("No Sources")],
        ),
      );
    } else {
      return Container(
        height: 115.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: soures.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 80.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: soures[index].id,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.0, 1.0))
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/logos/${soures[index].id}.png'))),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      " ${soures[index].name}",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 10.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      " ${soures[index].category}",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
