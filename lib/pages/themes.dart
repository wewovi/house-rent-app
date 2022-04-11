import 'package:flutter/material.dart';

Color blackColor = Color(0xff253342);
Color purpleColor = Color(0xff5F6AC4);
Color greyColor = Color(0xffAFAFAF);
Color orangeColor = Color.fromARGB(255, 221, 79, 103);
Color whiteColor = Color.fromARGB(255, 255, 255, 255);
Color shadowColor = Color(0x26616161);

// style
TextStyle primaryTitle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: blackColor,
);

TextStyle sectionTitle = TextStyle(
  color: blackColor,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);

TextStyle sectionSecondaryTitle = TextStyle(
  color: blackColor,
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

TextStyle contentTitle =const TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w800,
);

TextStyle infoText = TextStyle(
  color: greyColor,
  fontWeight: FontWeight.w400,
  fontSize: 15,
  overflow: TextOverflow.ellipsis
);

TextStyle secondaryTitle = TextStyle(
  color: blackColor,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle infoSecondaryTitle = TextStyle(
  color: greyColor,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle facilitiesTitle = TextStyle(
  color: blackColor,
  fontWeight: FontWeight.w500,
  fontSize: 10,
);

TextStyle descText = TextStyle(
  color: greyColor,
  fontWeight: FontWeight.w400,
  fontSize: 12,
);

TextStyle priceTitle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: greyColor,
);

TextStyle priceText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: purpleColor,
);

// Input Decoration Style
InputDecoration searchDecoration = InputDecoration(
  filled: true,
  fillColor: whiteColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide.none,
  ),
  hintText: "Find your dream home",
  contentPadding: EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  ),
  suffixIcon: Padding(
    padding: EdgeInsets.all(8),
    child: MaterialButton(
      onPressed: () {
        //Todo search code hear
      },
      color: purpleColor,
      minWidth: 39,
      height: 39,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        Icons.search,
        color: whiteColor,
        size: 16,
      ),
    ),
  ),
);
