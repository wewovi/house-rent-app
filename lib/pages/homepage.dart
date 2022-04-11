import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:splashscreen/splashscreen.dart';

import '../models/homeModel.dart';
import '../providers/homeProvider.dart';
import '../widgets/sliderCard.dart';
import 'listAllHomes.dart';
import 'themes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _drawerIconSize = 24;

  double _drawerFontSize = 17;
  var isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<HomeProvider>(context).fetchHome().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final homeData = home.homes;
    return SafeArea(
      child: MediaQuery(
        data: MediaQueryData(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('IRent'),
          ),
          backgroundColor: whiteColor,
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                    0.0,
                    1.0
                  ],
                      colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).primaryColor.withOpacity(0.5),
                  ])),
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "IRent",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home_work,
                      size: _drawerIconSize,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Manage Home',
                      style: TextStyle(
                          fontSize: 17, color: Theme.of(context).accentColor),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(HomesAll.routeName);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      size: _drawerIconSize,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 17, color: Theme.of(context).accentColor),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SplashScreen(title: Text("Splash Screen"))));
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NOTE: header

                  Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Material(
                      elevation: 6,
                      shadowColor: shadowColor,
                      borderRadius: BorderRadius.circular(15),
                      child: TextField(
                        decoration: searchDecoration,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 20.0),
                    child: Text(
                      "Find Your\nPerfect Place!",
                      style: primaryTitle,
                    ),
                  ),
                  Container(
                    height: 216,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: home.homes.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                              value: homeData[i],
                              child: SliderCard(),
                            ),
                          ),
                  ),
                  SizedBox(height: 15),
                  // NOTE: recommeded
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 30, bottom: 12),
                    child: Text(
                      "Recommended For You",
                      style: secondaryTitle,
                    ),
                  ),

                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Slider card

// Recommend Card
class RecommendCard extends StatelessWidget {
  final String cate;
  final String location;
  final double pricePerMonth;
  final String description;
  final String id;
  final String imagesUrl;
  bool isFavorite;
  final int rating;

  RecommendCard({
    required this.cate,
    required this.description,
    required this.id,
    required this.imagesUrl,
    required this.location,
    required this.pricePerMonth,
    required this.isFavorite,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 6,
        shadowColor: shadowColor,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: whiteColor,
          ),
          child: Row(
            children: [
              Image.asset(
                imagesUrl,
                width: 60,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cate,
                    style: contentTitle,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    location,
                    style: infoText,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [1, 2, 3, 4, 5].map((e) {
                      return Icon(
                        Icons.star,
                        size: 12,
                        color: (e <= rating) ? orangeColor : greyColor,
                      );
                    }).toList(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
