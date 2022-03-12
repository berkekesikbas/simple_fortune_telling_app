import 'package:flutter/material.dart';

Widget tarotCardWidget(int number) {
  return Container(
    height: 150,
    child: Card(
      child: Image.asset(
        'assets/tarot_card_images/${number}.jpg',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      margin: EdgeInsets.all(10),
    ),
  );
}

Widget defaultTarotCard(imagePath) {
  return Container(
    height: 150,
    child: Card(
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      margin: EdgeInsets.all(10),
    ),
  );
}

void onTapFunction() {}
