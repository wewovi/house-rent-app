import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/homeModel.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class HomeProvider with ChangeNotifier {
  //CollectionReference homesFirebase = FirebaseFirestore.instance.collection('homes');
  List<Home> _homes = [
    //  Home(
    //     isAvailable: true,
    //     kitchenImageUrl: 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1984&q=80',
    //     toiletImageUrl: 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1984&q=80',
    //   numberOfRooms: 4,
    //   frontViewImagesUrl: 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1984&q=80',

    //    cate: 'single room',
    //     id: 'h1',
    //      description: 'a house for sale',
    //       location: 'kukuazugu, walewale',
    //       pricePerMonth: 50.0, rating: 4),

    //    Home(
    //      isAvailable: true,
    //      numberOfRooms: 1,
    //       kitchenImageUrl: 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1984&q=80',
    //     toiletImageUrl: 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1984&q=80',

    //     frontViewImagesUrl: 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1984&q=80',
    //     cate: 'singleRoom',
    //      id: 'h2',
    //       description: 'a house for sale',
    //        location: 'Nayiri fong, walewale',
    //        pricePerMonth: 70.0, rating: 4),
  ];

  List<Home> get homes {
    return [..._homes];
  }

  Future<void> fetchHome() async {
    final url = Uri.parse(
        'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/homes.json');

    try {
      final response = await http.get(url);
      final extratedData = json.decode(response.body) as Map<String, dynamic>;
      List<Home> loadedHomes = [];
      extratedData.forEach((homeId, homeData) {
        loadedHomes.add(Home(
          landLoardName: homeData['landLoardName'],
          bedRoomUrl: homeData['bedRoomUrl'],
          id: homeId,
          isAvailable: homeData['isAvailable'],
          frontViewImagesUrl: homeData['frontViewImagesUrl'],
          cate: homeData['cate'],
          description: homeData['description'],
          location: homeData['location'],
          pricePerMonth: homeData['pricePerMonth'],
          kitchenImageUrl: homeData['kitchenImageUrl'],
          numberOfRooms: homeData['numberOfRooms'],
          toiletImageUrl: homeData['toiletImageUrl'],
        ));
      });
      _homes = loadedHomes;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addHome(Home home) async {
  
    final url = Uri.parse(
        'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/homes.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'isAvailable': home.isAvailable,
            'landLordName': home.landLoardName,
            'bedRoomUrl': home.bedRoomUrl,
            'kitchenImageUrl': home.kitchenImageUrl,
            'toiletImageUrl': home.toiletImageUrl,
            'numberOfRooms': home.numberOfRooms,
            'frontViewImagesUrl': home.frontViewImagesUrl,
            'cate': home.cate,
            'location': home.location,
            'pricePerMonth': home.pricePerMonth,
            'description': home.description,
          }));
      final newHome = Home(
          landLoardName: home.landLoardName,
          isAvailable: home.isAvailable,
          bedRoomUrl: home.bedRoomUrl,
          kitchenImageUrl: home.kitchenImageUrl,
          toiletImageUrl: home.toiletImageUrl,
          numberOfRooms: home.numberOfRooms,
          frontViewImagesUrl: home.frontViewImagesUrl,
          cate: home.cate,
          id: json.decode(response.body)['name'],
          description: home.description,
          location: home.location,
          pricePerMonth: home.pricePerMonth);
      _homes.add(newHome);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateStatus(String id, Home newHome) async {
    final proIndex = _homes.indexWhere((element) => element.id == id);
    if (proIndex >= 0) {
      final url = Uri.parse(
          'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/homes.json');
      await http.put(url, body: json.encode({'isAvailable': false}));
      _homes[proIndex] = newHome;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteHome(String id) async {
    final url = Uri.parse(
        'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/homes/$id.json');
    final existingHomeIndex = _homes.indexWhere((element) => element.id == id);
    Home? existingHome = _homes[existingHomeIndex];
    _homes.removeAt(existingHomeIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _homes.insert(existingHomeIndex, existingHome);
      notifyListeners();
      throw HttpException('Could not delete home.');
    }
    existingHome = null;
  }

  void removeHome(String id) {
    _homes.remove(id);
    notifyListeners();
  }

  String _searchString = '';
  Home findById(String id) {
    return _homes.firstWhere((element) => element.id == id);
  }

  List<Home> findByLocation() {
    return [
      ..._homes.where((element) => element.location.contains(_searchString))
    ];
  }
}
