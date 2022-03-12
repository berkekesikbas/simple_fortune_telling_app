//Aşk falinin sonucunun gözükeceği sayfa burası
//Bu sayfada önce bekleteceğiz sonra sonucu göstereceğiz
//Reklam eklenecek herşeyden öne buraya
import 'dart:convert';
import 'dart:math';

import 'package:fl_astrology/scaffolds/custom_page_scaffold2.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class GunlukFalSonucu extends StatefulWidget {
  const GunlukFalSonucu({Key key}) : super(key: key);

  @override
  _GunlukFalSonucuState createState() => _GunlukFalSonucuState();
}

class _GunlukFalSonucuState extends State<GunlukFalSonucu> {
  List falSonuclariDB;
  String falSonucu = "Bekleyiniz.";
  final random = new Random();

  @override
  void initState() {
    super.initState();
    askFaliJsonOku();
  }

  @override
  Widget build(BuildContext context) {
    //askFaliJsonOku();
    return Scaffold(
      body: CustomPageScaffold2(
        title: "Fal Sonucu",
        pageColor: Colors.orange.shade700,
        hasButton: true,
        body: falSonucuBody(),
        buttonTitle: "Menüye dön",
        onButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      ),
    );
  }

  Widget falSonucuBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.pink.shade200, BlendMode.darken),
          image: AssetImage("assets/ask_fali/sonucbackground.jpg"),
          fit: BoxFit.fill,
        ),
        color: Colors.pink,
      ),
      width: double.infinity,
      //height: 500,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            //falSonuclariDB[0]['fal_sonucu'].toString(),
            falSonucu,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void askFaliJsonOku() async {
    String okunanFal = await DefaultAssetBundle.of(context)
        .loadString('assets/data/gunluk_fali.json');

    var jsonOkunanFal = jsonDecode(okunanFal);
    List falSonuclari = jsonOkunanFal;
    int rastgeleSayi = 0 + random.nextInt((falSonuclari.length - 1) - 0);
    String gosterilecekFalSonucu =
        falSonuclari[rastgeleSayi]['fal_sonucu'].toString();
    setState(() {
      falSonucu = gosterilecekFalSonucu;
    });

    //debugPrint(falSonuclariDB[0]['fal_sonucu'].toString());
  }
}
