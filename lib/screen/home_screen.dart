import 'package:flutter/material.dart';
import 'package:news/widget/headline_slider.dart';
import 'package:news/widget/hot_news.dart';
import 'package:news/widget/top_channels.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadLineSliderWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Top - HeadLine',
            style: TextStyle(color: Colors.black , fontSize: 17.0 , fontWeight: FontWeight.bold),
          ),
        ),
        TopChannelWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Hot news',
            style: TextStyle(color: Colors.black , fontSize: 17.0 , fontWeight: FontWeight.bold),
          ),
        ),
        HotNews(),

      ],
    );
  }
}
