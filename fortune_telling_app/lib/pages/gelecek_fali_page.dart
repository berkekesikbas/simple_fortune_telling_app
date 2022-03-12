import 'dart:math';

import 'package:fl_astrology/admob_service.dart';
import 'package:fl_astrology/pages/home_page.dart';
import 'package:fl_astrology/scaffolds/custom_page_scaffold.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class GelecekFali extends StatefulWidget {
  const GelecekFali({Key key}) : super(key: key);

  @override
  _GelecekFaliState createState() => _GelecekFaliState();
}

class _GelecekFaliState extends State<GelecekFali> {
  AdMobService adMobService = AdMobService();

  FlipCardController _controller;
  FlipCardController _controller2;
  FlipCardController _controller3;
  FlipCardController _controller4;
  FlipCardController _controller5;
  FlipCardController _controller6;

  int rastgeleSayi;

  final random = new Random();
  String kendiBurcu;
  String partnerBurcu;
  String iliskiDurumu;
  String gelecekSorusu;
  bool kartSecildiMi =
      false; //Kartın dönmesi için true olmalı dönmesin istiyorsak false yapacağız.
  bool gelecekSorusuGirildi = false;
  bool kendiBurcuGirildi = false;
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
  List<String> gelecekSorusuList = [
    "Kariyer olarak beni ne bekliyor ?",
    "Maddi olarak beni ne bekliyor ?",
    "Genel olarak beni neler bekliyor ?",
    "Aşk hayatımda beni ne bekliyor ?",
  ];

  @override
  void initState() {
    super.initState();
    rastgeleSayi = 0 + random.nextInt(12 - 0);
    _controller = FlipCardController();
    _controller2 = FlipCardController();
    _controller3 = FlipCardController();
    _controller4 = FlipCardController();
    _controller5 = FlipCardController();
    _controller6 = FlipCardController();
    adMobService.loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageScaffold(
        title: 'Gelecek Falı',
        buttonTitle: 'Fal sonucumu gör',
        body: askFaliBody(),
        onBackPressed: () {
          Navigator.pop(context);
        },
        onButtonPressed: () {
          buttonFunc();
        },
        pageColor: Colors.pink.shade600,
      ),
    );
  }

  void buttonFunc() async {
    if (gelecekSorusuGirildi == true &&
        kendiBurcuGirildi == true &&
        kartSecildiMi == true) {
      //Ödüllü reklamı gösteriyoruz.
      //alertDialogGoster();
      popUpGoster();
    } else {
      Fluttertoast.showToast(
          msg: "Tüm alanları doldurduğunuzdan emin olun.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  popUpGoster() {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateBlueRocket,
    );
    popup.show(
      barrierDismissible: true,
      close: Container(),
      title: 'Gelecek Falı',
      content:
          'Fal sonucunuzu görmek için reklamı sonuna kadar izlemeniz gerekmektedir. Siz reklamı izlerken bizde falınızı yorumluyor olacağız.',
      actions: [
        popup.button(
          label: 'Menüye Dön',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        popup.button(
          label: 'Falımı Göster',
          onPressed: () {
            Fluttertoast.showToast(
                msg: "Siz reklamı izlerken bizde falınızı yorumluyoruz.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.lightGreen,
                textColor: Colors.white,
                fontSize: 24.0);
            adMobService.showRewardAd(context);
          },
        ),
      ],
      // bool barrierDismissible = false,
      // Widget close,
    );
  }

  alertDialogGoster() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlue,
          title: new Text(
            "Gelecek Falı",
            style: TextStyle(color: Colors.white),
          ),
          content: new Text(
            "Bu falın sonucunu görmek için reklamı sonuna kadar izlemelisiniz.",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Menüye dön",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            new FlatButton(
              child: new Text(
                "Fal sonucumu göster",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Siz reklamı izlerken bizde falınızı yorumluyoruz.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.lightGreen,
                    textColor: Colors.white,
                    fontSize: 24.0);
                adMobService.showRewardAd(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget askFaliBody() {
    //int rastgeleSayi = 0 + random.nextInt(12 - 0);
    return Form(
      child: Column(
        children: [
          dropDownSizinBurcunuz(),
          SizedBox(height: 10),
          dropDownGelecekSorusu(),
          SizedBox(height: 10),
          Text(
            "1 Adet Kart Seçiniz",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tarotCardFlip(rastgeleSayi),
              tarotCardFlip2(rastgeleSayi),
              tarotCardFlip3(rastgeleSayi),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tarotCardFlip4(rastgeleSayi),
              tarotCardFlip5(rastgeleSayi),
              tarotCardFlip6(rastgeleSayi),
            ],
          ),

          //SizedBox(height: 25),
          //containerImage(),
        ],
      ),
    );
  }

  GestureDetector tarotCardFlip(int rastgeleSayi) {
    return GestureDetector(
      onTap: () {
        if (kartSecildiMi == false) {
          _controller.toggleCard();
          setState(() {
            kartSecildiMi = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Tarot kartını zaten seçtiniz.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: FlipCard(
        controller: _controller,
        front: frontCard(),
        back: backCard(rastgeleSayi),
        flipOnTouch: false,
      ),
    );
  }

  GestureDetector tarotCardFlip2(int rastgeleSayi) {
    return GestureDetector(
      onTap: () {
        if (kartSecildiMi == false) {
          _controller2.toggleCard();
          setState(() {
            kartSecildiMi = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Tarot kartını zaten seçtiniz.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: FlipCard(
        controller: _controller2,
        front: frontCard(),
        back: backCard(rastgeleSayi),
        flipOnTouch: false,
      ),
    );
  }

  GestureDetector tarotCardFlip3(int rastgeleSayi) {
    return GestureDetector(
      onTap: () {
        if (kartSecildiMi == false) {
          _controller3.toggleCard();
          setState(() {
            kartSecildiMi = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Tarot kartını zaten seçtiniz.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: FlipCard(
        controller: _controller3,
        front: frontCard(),
        back: backCard(rastgeleSayi),
        flipOnTouch: false,
      ),
    );
  }

  GestureDetector tarotCardFlip4(int rastgeleSayi) {
    return GestureDetector(
      onTap: () {
        if (kartSecildiMi == false) {
          _controller4.toggleCard();
          setState(() {
            kartSecildiMi = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Tarot kartını zaten seçtiniz.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: FlipCard(
        controller: _controller4,
        front: frontCard(),
        back: backCard(rastgeleSayi),
        flipOnTouch: false,
      ),
    );
  }

  GestureDetector tarotCardFlip5(int rastgeleSayi) {
    return GestureDetector(
      onTap: () {
        if (kartSecildiMi == false) {
          _controller5.toggleCard();
          setState(() {
            kartSecildiMi = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Tarot kartını zaten seçtiniz.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: FlipCard(
        controller: _controller5,
        front: frontCard(),
        back: backCard(rastgeleSayi),
        flipOnTouch: false,
      ),
    );
  }

  GestureDetector tarotCardFlip6(int rastgeleSayi) {
    return GestureDetector(
      onTap: () {
        if (kartSecildiMi == false) {
          _controller6.toggleCard();
          setState(() {
            kartSecildiMi = true;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Tarot kartını zaten seçtiniz.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: FlipCard(
        controller: _controller6,
        front: frontCard(),
        back: backCard(rastgeleSayi),
        flipOnTouch: false,
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
            "Gelecek Falı",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Container dropDownSizinBurcunuz() {
    return Container(
      //alignment: Alignment.centerLeft,
      //width: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ask_fali/bg3.jpg"),
            fit: BoxFit.cover,
          ),
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 8),
          Text(
            "Burcunuz:",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            hint: Text(
              "Seçiniz",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            dropdownColor: Colors.grey,
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

  Container dropDownGelecekSorusu() {
    return Container(
      //alignment: Alignment.centerLeft,
      //width: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ask_fali/bg3.jpg"),
            fit: BoxFit.cover,
          ),
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 8),
          Text(
            "Sorunuz:",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            hint: Text(
              "Seçiniz",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            dropdownColor: Colors.grey,
            items: gelecekSorusuList.map((oankiSoru) {
              return DropdownMenuItem(
                child: Container(
                  width: 180,
                  child: Text(
                    oankiSoru,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
                value: oankiSoru,
              );
            }).toList(),
            onChanged: (secilenSoru) {
              setState(() {
                gelecekSorusu = secilenSoru;
                gelecekSorusuGirildi = true;
              });
            },
            value: gelecekSorusu,
          ),
        ],
      ),
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

  //Kartın ilk görünen yüzü
  Container frontCard() {
    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/tarot_card_images/default.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container backCard(int rastgeleSayi) {
    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/tarot_card_images/${rastgeleSayi}.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
