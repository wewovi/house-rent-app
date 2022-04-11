import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/homeModel.dart';
import '../pages/details.dart';
import '../pages/themes.dart';

class SliderCard extends StatefulWidget {

 

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  bool isLiked = false;
  void toggelLiked(){
    setState(() {
      isLiked = !isLiked;
    });
    
  }





  @override
  Widget build(BuildContext context) {
   final home= Provider.of<Home>(context);
    
    return InkWell(
      onTap: () {
        
         Navigator.pushNamed(context, DetailPage.routeName, arguments: {'id':home.id,'cate': home.cate});
      },
      child: SizedBox(
        width: 230,
        child: Card(
   
          shadowColor: shadowColor,
          elevation: 5,
          
          child: Stack(
          
            fit: StackFit.loose,
           
            children: [
              ClipRRect(
                borderRadius:const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                child: Image.network(
                 home.frontViewImagesUrl,
                  
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              
                 Positioned(
                   bottom: 10,
                   left: 0,
                   right: 0,
                   child: Container(
                     
                     decoration: BoxDecoration(
                       color: Colors.black54
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(left:5.0, bottom: 5, top: 5),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                               home.cate,
                                 style: contentTitle,
                               ),
                               Text(
                                 
                                 home.location,
                                 style: infoText,
                               )
                             ],
                           ),
                           
                       Padding(
                         padding: const EdgeInsets.only(right:5, left: 0),
                         child: Row(
                         children: [1, 2, 3, 4, 5].map((e) {
                           return Icon(
                             Icons.star,
                             color: (e <= 5) ? Colors.red : greyColor,
                             size: 12,
                           );
                         }).toList(),
                   ),
                       ),
                                  
                         ],
                       ),
                     ),
                   ),
                 ),
                  IconButton(onPressed: toggelLiked, icon:isLiked ? Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}