import 'package:flutter/material.dart';
import 'package:housetorent/pages/listAllHomes.dart';
import 'package:housetorent/pages/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'models/homeModel.dart';
import 'models/profileModel.dart';
import 'pages/details.dart';
import 'pages/editProfile.dart';
import 'pages/homepage.dart';
import 'pages/homeuploadpage.dart';
import 'pages/login_page.dart';
import 'providers/authProvider.dart';
import 'providers/booked.dart';
import 'providers/homeProvider.dart';
import 'providers/profilesProvider.dart';
import 'shared_widgets/bottom.dart';

void main() async {
  List<Home> _items = [];

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider(
            create: ((context) => Home(
                landLoardName: '',
                bedRoomUrl: '',
                toiletImageUrl: '',
                numberOfRooms: 0,
                kitchenImageUrl: '',
                isAvailable: true,
                frontViewImagesUrl: '',
                cate: '',
                id: '',
                description: '',
                location: '',
                pricePerMonth: 0.0))),
        ChangeNotifierProvider.value(value: Booked()),
        ChangeNotifierProvider.value(
            value: Profile(email: '', locatioin: '', name: '', phone: '')),
        ChangeNotifierProvider.value(
            value: BookedItem(dateTime: DateTime.now(), id: '', homes: _items))
      ],
      child: MyApp(),
    ),
  );
  //await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: Consumer<Auth>(
          builder: (context, auth, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(
                  seconds: 5,
                  navigateAfterSeconds: auth.isAuth
                      ? BottomNav()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (context, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreenOne()
                                  : const LoginPage()),
                  // BottomNav(), //: const LoginPage(),
                  title: const Text(
                    'iRent',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  image: Image.network(
                      'https://media.istockphoto.com/photos/home-with-blue-siding-and-stone-faade-on-base-of-home-picture-id1272128530?s=612x612'),
                  backgroundColor: Colors.white,
                  styleTextUnderTheLoader: TextStyle(),
                  photoSize: 100.0,
                  loaderColor: Colors.red),
              routes: {
                '/log-in': (context) => LoginPage(),
                '/details-page': (context) => DetailPage(),
                '/home-upload-page': (context) => HomeUploadPage(),
                '/home-page': (context) => HomePage(),
                '/all-homes': (context) => const HomesAll(
                      id: 'id',
                    ),
                '/edit-profile': (context) => EditProfile()
              }),
        ));
  }
}
