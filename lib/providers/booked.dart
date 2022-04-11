import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/homeModel.dart';
import '../models/profileModel.dart';

class BookedItem with ChangeNotifier {
  final String id;

  final List<Home> homes;
  final DateTime dateTime;

  BookedItem({required this.id, required this.dateTime, required this.homes});
}

class Booked with ChangeNotifier {
  List<BookedItem> _book = [];

  List<BookedItem> get books {
    return [..._book];
  }

  //final profilePro = Provider.of<Profile>(context, listen: false);
  List<Profile> profileItem = [
    Profile(email: '', locatioin: '', name: '', phone: '')
  ];
  Future<void> addBookies(
    List<Home> homeItem,
  ) async {
    final url = Uri.parse(
        'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/bookies.json');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'dateTime': timeStamp.toIso8601String(),
          'user': profileItem.map((e) => {
                'userName': e.name,
                'email': e.email,
                'phone': e.phone,
                'location': e.locatioin
              }),
          'homes': homeItem
              .map((e) => {
                    'id': e.id,
                    'amount': e.pricePerMonth,
                    'location': e.location,
                    'numberOfRooms': e.numberOfRooms,
                    'category': e.cate,
                    'isAvailable': e.isAvailable,
                    'landLordName': e.landLoardName
                  })
              .toList()
        }));
    print(response.statusCode);
    _book.insert(
        0,
        BookedItem(
            id: json.decode(response.body)['name'],
            dateTime: timeStamp,
            homes: homeItem));
    notifyListeners();
  }

  Future<void> fetchBookies() async {
    final url = Uri.parse(
        'https://irent-75578-default-rtdb.europe-west1.firebasedatabase.app/bookies.json');
    final response = await http.get(url);
    final List<BookedItem> loadedBookies = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((bookId, bookData) {
      loadedBookies.add(
        BookedItem(
          id: bookId,
          dateTime: DateTime.parse(bookData['dateTime']),
          homes: (bookData['home'] as List<dynamic>)
              .map((e) => Home(
                  landLoardName: e['landLordName'],
                  bedRoomUrl: e['bedRoomUrl'],
                  isAvailable: e['isAvailable'],
                  frontViewImagesUrl: e['frontViewImagesUrl'],
                  cate: e['cate'],
                  id: e['id'],
                  description: e['description'],
                  location: e['location'],
                  pricePerMonth: e['pricePerMonth'],
                  kitchenImageUrl: e['kitchenImageUrl'],
                  numberOfRooms: e['numberOfRooms'],
                  toiletImageUrl: e['toiletImageUrl']))
              .toList(),
        ),
      );
    });
    _book = loadedBookies.reversed.toList();
    notifyListeners();
  }
}
