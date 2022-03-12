import 'package:fl_astrology/pages/ask_fali_sonuc.dart';
import 'package:fl_astrology/scaffolds/custom_page_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../admob_service.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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
    "Sevgiliyiz",
    "Arkadaşız",
    "Ayrıldık",
    "Tanışmıyoruz",
    "Yeni tanıştık",
    "Platonik",
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
        title: 'Gerekli Bilgileri Doldurunuz',
        buttonTitle: 'Fal sonucumu gör',
        body: askFaliBody(),
        onBackPressed: () {
          Navigator.pop(context);
        },
        onButtonPressed: () {
          if (_formKey.currentState.validate()) {
            if (kendiBurcuGirildi == true && partnerBurcuGirildi == true && iliskiDurumuGirildi == true) {
              adMobService.showInterAd();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AskFaliSonucu(),
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
                msg: "Lütfen isim bölümlerini doldurunuz.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        pageColor: Colors.red.shade600,
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

  Widget askFaliBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          textFormFieldAdSoyad(),
          SizedBox(height: 10),
          textFormFieldPartnerAdSoyad(),
          SizedBox(height: 10),
          dropDownSizinBurcunuz(),
          SizedBox(height: 10),
          dropDownPartnerBurcu(),
          SizedBox(height: 10),
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
          colorFilter: ColorFilter.mode(Colors.pink.shade200, BlendMode.darken),
          image: AssetImage("assets/ask_fali/lovecard.jpeg"),
          fit: BoxFit.fill,
        ),
        color: Colors.pink,
      ),
      //width: 400,
      height: 180,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Aşk falı herkesin merak duyduğu fallardan biridir. Evrenin en güzel duygularından biri olan aşkın, tanımını yapan fal, aşk falı olarak bilinir.",
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
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 8),
          Text(
            "İlişki durumu:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            hint: Text(
              "Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dropdownColor: Colors.redAccent.shade200,
            items: iliskiDurumlari.map((oankiIliski) {
              return DropdownMenuItem(
                child: Text(
                  oankiIliski,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(width: 8),
          Text(
            "Diğer kişinin burcu:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(width: 8),
          Text(
            "Sizin burcunuz:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Sizin isminiz",
      ),
      validator: (value) {
        return value.isEmpty ? "Bu alan boş bırakılamaz" : null;
      },
    );
  }
}
