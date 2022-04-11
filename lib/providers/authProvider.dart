import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{

  String? _token;
  DateTime? _expiryDate;
String? _userId;
Timer? _authTimer;

bool get isAuth{
  return token != null;
}

String? get token{
  if(_expiryDate != null && _expiryDate!.isAfter(DateTime.now())){
    return _token;
  }
  return null;
}

String? get userId{
  return _userId;
}

Future<void> signUp(String email, String password)async{
  final url =Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCl9qnIy0n9CwCaPRCAADg3MJ1I04HsgbQ');

  try {
    final response = await http.post(url, body: json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true
    }));
    final responseData = json.decode(response.body);
    if (responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token':_token,
      'userId': _userId,
      'expiryDate':_expiryDate!.toIso8601String(),
    });
    prefs.setString('userData', userData);
  } catch (e) {
    throw e;
  }
}

Future<void> login(String email, String password)async{
  final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCl9qnIy0n9CwCaPRCAADg3MJ1I04HsgbQ');
  try {
    final response = await http.post(url, body: json.encode({
      'email':email,
      'password':password,
      'returnSecureToken': true,
    }));
    
     final responseData = json.decode(response.body);
    
    if (responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token':_token,
      'userId': _userId,
      'expiryDate':_expiryDate!.toIso8601String(),
    });
    prefs.setString('userData', userData);
  } catch (e) {
    throw e;
  }
}

Future<bool> tryAutoLogin() async{
  final prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('userData')){
    return false;
  }
  final extratedUserData = json.decode(prefs.getString('userData').toString()) as Map<String, Object>;
  final expiryDate = DateTime.parse(extratedUserData['userData'].toString());
  if(expiryDate.isBefore(DateTime.now())){
    return false;
  }
  _token = extratedUserData['token'].toString();
  _userId = extratedUserData['userId'].toString();
  _expiryDate = expiryDate;
  notifyListeners();
  _autoLogout();
  return true;
}
 
 Future<void> logout()async{
   _token = null;
   _userId = null;
   _expiryDate = null;
   if(_authTimer != null){
     _authTimer!.cancel();
     _authTimer = null;

   }
   notifyListeners();
   final prefs = await SharedPreferences.getInstance();
   prefs.clear();
 }

 void _autoLogout(){
if(_authTimer != null){
  _authTimer!.cancel();
}
final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
_authTimer = Timer(Duration(seconds: timeToExpire), logout);
 }

}

