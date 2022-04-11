// import 'package:app/providers/booked.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/homeModel.dart';
// import '../pages/details.dart';
// import '../pages/themes.dart';

// class SliderCardi extends StatefulWidget {

 

//   @override
//   State<SliderCardi> createState() => _SliderCardiState();
// }

// class _SliderCardiState extends State<SliderCardi> {
//   bool isLiked = false;
//   void toggelLiked(){
//     setState(() {
//       isLiked = !isLiked;
//     });
    
//   }





//   @override
//   Widget build(BuildContext context) {
//    final home= Provider.of<BookedItem>(context);
    
//      List<BookedItem> homeItem=[
//     BookedItem(id: home.id, dateTime: home.dateTime, homes: home.homes)
//   ];
//     return  Stack(
//     children: [
//       // NOTE: thumbnail image
//       Container(
//         width: MediaQuery.of(context).size.width,
//         height: 296,
//         child: Image.network(
//           homePro.frontViewImagesUrl,
//         //homePro.frontViewImagesUrl,
//           height: 296,
//           width: MediaQuery.of(context).size.width,
//           fit: BoxFit.cover,
//         ),
//       ),
//       // NOTE: content
//       Column(
//         children: [
//           SizedBox(
//             height: 230,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius:
//                   BorderRadius.vertical(top: Radius.circular(30)),
//               color: whiteColor,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // NOTE: title
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 30,
//                     vertical: 14,
//                   ),
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             homePro.cate,
//                             style: secondaryTitle,
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Text(
//                             homePro.location,
//                             style: infoSecondaryTitle,
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Row(
//                         children: [1,2,3,4,5].map((ratings) {
//                           return Icon(
//                             Icons.star,
//                             size: 12,
//                             color: (ratings <= 5) ? orangeColor : greyColor,
//                           );
//                         }).toList(),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal:30.0),
//                   child:homePro.isAvailable? Text('Status: Available') : Text('Status: Booked'),
//                 ),
//                 SizedBox(height: 10,),
//                 // NOTE: agent
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Text(
//                     "Listing Agent",
//                     style: sectionSecondaryTitle,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Row(
//                     children: [
//                       Image.network(
//                         "https://media.istockphoto.com/photos/townhouse-for-sale-picture-id90409346?s=612x612",
//                         width: 50,
//                       ),
//                       SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Pasiba",
//                             style: contentTitle,
//                           ),
//                           Text(
//                             homePro.landLoardName,
//                             style: infoText,
//                           ),
//                           Text(
//                             "0553599006",
//                             style: infoText,
//                           ),
//                           Text('wewovi10.jw@gmail.com', style: infoText,),
//                         ],
//                       ),
//                       Spacer(),
//                       Row(
//                         children: [
//                           InkWell(
//                             onTap: () {},
//                             child: Image.network(
//                               "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=399&q=80",
//                               width: 30,
//                             ),
//                           ),
//                           SizedBox(width: 10),
                         
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 14,
//                 ),
//                 // NOTE: facilities
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Text(
//                     "House Facilities",
//                     style: sectionSecondaryTitle,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 115,
//                   padding: EdgeInsets.only(bottom: 5),
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       const SizedBox(width: 30),
//                       InkWell(
//                         onTap: (){
//                          showModalBottomSheet(context: context, builder: (context)=>Container(
//                            height: 800,
//                            decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),),
//                            child: Image.network(homePro.toiletImageUrl, fit: BoxFit.fill,),
//                            ),
//                          );
//                         },
//                         child: FacilityCard(
//                           imageUrl: homePro.toiletImageUrl,
//                           title: "Toilet",
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       InkWell(
//                          onTap: (){
//                          showModalBottomSheet(context: context, builder: (context)=>Container(
//                            height: 800,
//                            decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),),
//                            //Todo: add bedroom data
//                            child: Image.network(homePro.toiletImageUrl, fit: BoxFit.fill,),
//                            ),
//                          );
//                         },
//                         child: FacilityCard(
//                           imageUrl: homePro.bedRoomUrl,
//                           title: "${homePro.numberOfRooms} Bedrooms",
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       InkWell(
//                          onTap: (){
//                          showModalBottomSheet(context: context, builder: (context)=>Container(
//                            height: 800,
//                            decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),),
//                            child: Image.network(homePro.kitchenImageUrl, fit: BoxFit.fill,),
//                            ),
//                          );
//                         },
//                         child: FacilityCard(
//                           imageUrl: homePro.kitchenImageUrl,
//                           title: "Kitchen",
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           // NOTE: description
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: Text(
//               "Description",
//               style: sectionSecondaryTitle,
//             ),
//           ),
//           SizedBox(height: 10),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: Text(
//             homePro.description,
//               style: descText,
//             ),
//           ),
//          // SizedBox(height: 110),
//         ],
//       ),
//       // NOTE: button back
//       Positioned(
//         top: 20,
//         left: 20,
//         child: MaterialButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           minWidth: 30,
//           height: 30,
//           padding: EdgeInsets.all(5),
//           color: whiteColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Icon(
//             Icons.arrow_back_ios_outlined,
//             size: 14,
//           ),
//         ),
//       ),
//     ],
//     ),
//   }
// }