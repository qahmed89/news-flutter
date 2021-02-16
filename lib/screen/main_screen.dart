import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/bottom_navbar_bloc.dart';
import 'package:news/screen/home_screen.dart';
import 'package:news/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text(
            'NewsApp',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          initialData: _bottomNavBarBloc.defaultItem,
          stream: _bottomNavBarBloc.itemStream,

          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return HomeScreen();
                break;
              case NavBarItem.SOURCES:
                return TestScreen("Sources");
                break;

              case NavBarItem.SEARCH:
                return TestScreen("Search");
                break;

            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,

        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {

          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[100],
                      spreadRadius: 0,
                      blurRadius: 10.0)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: BottomNavigationBar(

                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Style.Colors.mainColor,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,

                items: [
                  BottomNavigationBarItem(
                    title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Home",
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    icon: Icon(EvaIcons.homeOutline),
                    activeIcon: Icon(EvaIcons.home),),
                  BottomNavigationBarItem(
                    title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Sources",
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),),
                  BottomNavigationBarItem(
                    title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Search",
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    icon: Icon(EvaIcons.searchOutline),
                    activeIcon: Icon(EvaIcons.search),),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget TestScreen (String title) {


    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              'TestScreen $title'
          )
        ],
      ),
    );
  }

}

