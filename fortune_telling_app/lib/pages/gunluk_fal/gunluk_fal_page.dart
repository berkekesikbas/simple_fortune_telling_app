import 'package:fl_astrology/pages/gunluk_fal/gunluk_fal_sonuc.dart';
import 'package:fl_astrology/scaffolds/custom_page_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../admob_service.dart';

//Günlük Fal Sayfası
class GunlukFal extends StatefulWidget {
  @override
  _GunlukFalState createState() => _GunlukFalState();
}

class _GunlukFalState extends State<GunlukFal> {
  AdMobService adMobService = AdMobService();
  final _formKey = GlobalKey<FormState>();
  String kendiBurcu;
  String partnerBurcu;
  String iliskiDurumu;
  bool iliskiDurumuGirildi = false;
  bool kendiBurcuGirildi = false;
  bool partnerBurcuGirildi = false;
  List<String> burclar = [
    "Koç",
    "Boğa",
    "İkizler",
    "Yengeç",
    "Aslan",
    "Başak",
    "Terazi",
    "Akrep",
    "Yay",
    "Oğlak",
    "Kova",
    "Balık",
    "Bilmiyorum",
  ];
  List<String> iliskiDurumlari = [
    "Mutlu hissediyorum",
    "Üzgün hissediyorum",
    "Normal hissediyorum",
    "Heyecanlı hissediyorum",
    "Öfkeli hissediyorum",
    "Umutsuz hissediyorum",
    "Bilmiyorum",
  ];

  @override
  void initState() {
    super.initState();
    adMobService.createInterAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageScaffold(
        title: 'Günlük Fal Standart',
        buttonTitle: 'Fal sonucumu gör',
        body: gunlukFalBody(),
        onBackPressed: () {
          Navigator.pop(context);
        },
        onButtonPressed: () {
          if (_formKey.currentState.validate()) {
            if (kendiBurcuGirildi == true && iliskiDurumuGirildi == true) {
              adMobService.showInterAd();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GunlukFalSonucu(),
                ),
              );
            } else {
              Fluttertoast.showToast(
                  msg: "Tüm bilgileri doldurduğunuzdan emin olun.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            Fluttertoast.showToast(
                msg: "Lütfen isminizi giriniz.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        pageColor: Colors.lightGreen,
      ),
    );
  }

  void alertDialogGoster(String mesaj) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.redAccent.shade200,
          title: new Text(
            "Uyarı",
            style: TextStyle(color: Colors.white),
          ),
          content: new Text(
            mesaj,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Tamam",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget gunlukFalBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          textFormFieldAdSoyad(),
          SizedBox(height: 10),
          //textFormFieldPartnerAdSoyad(),
          //SizedBox(height: 10),
          dropDownSizinBurcunuz(),
          SizedBox(height: 10),
          //dropDownPartnerBurcu(),
          //SizedBox(height: 10),
          dropdownIliskiDurumu(),
          SizedBox(height: 25),
          containerImage(),
        ],
      ),
    );
  }

  Container containerImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.green.withOpacity(0.5), BlendMode.darken),
          image: AssetImage("assets/ask_fali/kure.jpg"),
          fit: BoxFit.cover,
        ),
        color: Colors.black,
      ),
      //width: 400,
      height: 180,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Günlük olarak bakılan bu falımız verdiğiniz bilgilere göre genel anlamda sizi yorumlayan bir fal çeşidimizdir. Eğer diğer fallarımıza bakmak istiyorsanız menüye dönebilirsiniz.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Container dropdownIliskiDurumu() {
    return Container(
      //alignment: Alignment.centerLeft,
      //width: 100,
      decoration: BoxDecoration(
          color: Colors.lightGreen, borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 8),
          Text(
            "Ruh haliniz:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            hint: Text(
              "Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dropdownColor: Colors.lightGreen.shade400,
            items: iliskiDurumlari.map((oankiIliski) {
              return DropdownMenuItem(
                child: Text(
                  oankiIliski,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                value: oankiIliski,
              );
            }).toList(),
            onChanged: (secilenIliski) {
              setState(() {
                iliskiDurumu = secilenIliski;
                iliskiDurumuGirildi = true;
              });
            },
            value: iliskiDurumu,
          ),
        ],
      ),
    );
  }

  Container dropDownPartnerBurcu() {
    return Container(
      //alignment: Alignment.centerLeft,
      //width: 100,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 8),
          Text(
            "Diğer kişinin burcu:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            hint: Text(
              "Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dropdownColor: Colors.redAccent.shade200,
            items: burclar.map((oankiBurc) {
              return DropdownMenuItem(
                child: Text(
                  oankiBurc,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                value: oankiBurc,
              );
            }).toList(),
            onChanged: (secilenBurc) {
              setState(() {
                partnerBurcu = secilenBurc;
                partnerBurcuGirildi = true;
              });
            },
            value: partnerBurcu,
          ),
        ],
      ),
    );
  }

  Container dropDownSizinBurcunuz() {
    return Container(
      //alignment: Alignment.centerLeft,
      //width: 100,
      decoration: BoxDecoration(
          color: Colors.lightGreen, borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 8),
          Text(
            "Burcunuz:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            hint: Text(
              "Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dropdownColor: Colors.lightGreen.shade400,
            items: burclar.map((oankiBurc) {
              return DropdownMenuItem(
                child: Text(
                  oankiBurc,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                value: oankiBurc,
              );
            }).toList(),
            onChanged: (secilenBurc) {
              setState(() {
                kendiBurcu = secilenBurc;
                kendiBurcuGirildi = true;
              });
            },
            value: kendiBurcu,
          ),
        ],
      ),
    );
  }

  TextFormField textFormFieldPartnerAdSoyad() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Diğer kişinin ismi",
      ),
      validator: (value) {
        return value.isEmpty ? "Bu alan boş bırakılamaz" : null;
      },
    );
  }

  TextFormField textFormFieldAdSoyad() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Lütfen isminizi yazınız",
      ),
      validator: (value) {
        return value.isEmpty ? "Bu alan boş bırakılamaz" : null;
      },
    );
  }
}
