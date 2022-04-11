import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/profileModel.dart';

class ProfileProvider with ChangeNotifier{
 
 List<Profile> _profile=[];

List<Profile> get profile{
  return[..._profile];
}

Future<void> addProfile(Profile profile)async{

  final url = Uri.parse('https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/users.json');
try {
final response = await http.post(url, body: json.encode({
  'name':profile.name,
  'email':profile.email,
  'phone':profile.phone,
  'location':profile.locatioin,
}));
print(response.statusCode);
  final newProfile= Profile(
  
  
   email: profile.email, 
   locatioin: profile.locatioin, 
   name: profile.name, 
   phone: profile.phone);
   _profile.add(newProfile);
   notifyListeners();
  
} catch (e) {
  throw (e);
}
 
}
Future<void> fetchProfile() async{
   final url = Uri.parse( 'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/users.json');
   
   try {
      final response =await http.get(url);
      final extratedData = json.decode(response.body) as Map<String, dynamic>;
       List<Profile> loadedProfiles = [];
      extratedData.forEach((profileId, profileData) {
        loadedProfiles.add(Profile(
         email: profileData['email'],
         name: profileData['name'],
         phone: profileData['phone'],
         locatioin: profileData['location'],
        ));
      });
      _profile = loadedProfiles;
      notifyListeners();
   } catch (e) {
     rethrow;
   }
  
}

void deleteProfile(String id){
 _profile.remove(id);
 notifyListeners();
}


}