import 'package:flutter/cupertino.dart';

class Profile with ChangeNotifier{
  Profile({required this.email, required this.locatioin, required this.name, required this.phone, });
  final String name;
  final String locatioin;
  final String email;
  final String phone;

  

}