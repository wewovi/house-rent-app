import 'package:flutter/material.dart';

import '../widgets/header_widget.dart';

class Settings extends StatelessWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
           Container(height: 80, child: const HeaderWidget(100,false,Icons.house_rounded),),

           
        ],
      ) ,
    );
  }
}