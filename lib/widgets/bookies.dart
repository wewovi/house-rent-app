import 'package:flutter/material.dart';

class Bookies extends StatelessWidget {
   Bookies({
    required this.imageUrl,
    required this.landlord,
    required this.price,
    required this.category,
    Key? key,
  }) : super(key: key);
  final String imageUrl;
  final String landlord;
  final double price;
final String category;
  @override
  Widget build(BuildContext context) {
    return   ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('$imageUrl'),
      
      ),
      title: Text('landloard'),

    subtitle: Text('category'),
    trailing: Text('price per month'),
    );
  }
}