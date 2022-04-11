import 'package:flutter/material.dart';

class Home with ChangeNotifier {
  final String cate;

  final String location;
  final double pricePerMonth;
  final String description;
  final String id;
  final String frontViewImagesUrl;
  final String kitchenImageUrl;
  final String toiletImageUrl;
  final int numberOfRooms;
  final String bedRoomUrl;

  bool isAvailable = false;
  final String landLoardName;

  Home(
      {required this.landLoardName,
      required this.bedRoomUrl,
      required this.isAvailable,
      required this.frontViewImagesUrl,
      required this.cate,
      required this.id,
      required this.description,
      required this.location,
      required this.pricePerMonth,
      required this.kitchenImageUrl,
      required this.numberOfRooms,
      required this.toiletImageUrl});
}
