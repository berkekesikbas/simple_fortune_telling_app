import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

GestureDetector containerImageSpecify(
    String imagePath, String imageText, void onTapFunction(), BuildContext context, String baslik) {
  return GestureDetector(
    onTap: () {
      onTapFunction();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.pink.shade200, BlendMode.darken),
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
        color: Colors.pink,
      ),
      width: 300,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            baslik,
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                imageText,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onTapFunction();
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black45,
              size: 15,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
              primary: Colors.white, // <-- Button color
              onPrimary: Colors.red, // <-- Splash color
            ),
          ),
          /*Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20,
          ),*/
        ],
      ),
    ),
  );
}
