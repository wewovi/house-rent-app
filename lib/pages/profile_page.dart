import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profileModel.dart';
import '../providers/profilesProvider.dart';
import '../widgets/header_widget.dart';
import 'editProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfileProvider>(context).fetchProfile().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProfile.routeName);
              },
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              )),
          // Container(
          //   margin: EdgeInsets.only( top: 16, right: 16,),
          //   child: Stack(
          //     children: <Widget>[
          //       Icon(Icons.notifications),
          //       Positioned(
          //         right: 0,
          //         child: Container(
          //           padding: EdgeInsets.all(1),
          //           decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
          //           constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
          //           child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
      body: _isLoading
          ? Center(child: Image.asset('assets/no_user.png'))
          : Consumer<ProfileProvider>(
              builder: (_, notifier, __) => ListView.builder(
                itemBuilder: (context, index) => ProfileWidget(
                    email: notifier.profile[index].email,
                    location: notifier.profile[index].locatioin,
                    name: notifier.profile[index].name,
                    phone: notifier.profile[index].phone),
                itemCount: 1,
              ),
            ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.email,
    required this.location,
    required this.name,
    required this.phone,
  }) : super(key: key);

  final String name;
  final String email;
  final String location;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Profile>(context);
    return Column(
      children: [
        Container(
          height: 80,
          child: const HeaderWidget(100, false, Icons.house_rounded),
        ),
        SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(100),
                      //     border: Border.all(width: 5, color: Colors.white),
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                      //     ],
                      //   ),
                      //   child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4.0),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                "User Information",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Card(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        ...ListTile.divideTiles(
                                          color: Colors.grey,
                                          tiles: [
                                            ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              leading: Icon(Icons.my_location),
                                              title: Text("Location"),
                                              subtitle: Text(location),
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.email),
                                              title: Text("Email"),
                                              subtitle: Text(email),
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.phone),
                                              title: const Text("Phone"),
                                              subtitle: Text(phone),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
