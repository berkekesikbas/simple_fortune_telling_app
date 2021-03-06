import 'package:fl_astrology/pages/gelecek_fali_page.dart';
import 'package:fl_astrology/pages/gunluk_fal/gunluk_fal_page.dart';
import 'package:fl_astrology/widgets/custom_bottom_bar.dart';
import 'package:fl_astrology/widgets/home_page_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../internet_service.dart';
import 'ask_fali_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    CheckInternet().checkConnection(context);
  }

  @override
  void dispose() {
    CheckInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 248, 251, 1),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentTab,
        onTap: (int val) {
          if (val == _currentTab) return;
          setState(() {
            _currentTab = val;
          });
        },
        items: [
          /* CustomBottomBarItem(icon: Icons.home),
          CustomBottomBarItem(icon: Icons.bookmark),
          CustomBottomBarItem(icon: Icons.person),
          CustomBottomBarItem(icon: Icons.settings)*/
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Falinna ??cretsiz',
                          style: TextStyle(
                            color: Color.fromRGBO(52, 53, 62, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                          ),
                        ),
                        Text(
                          'Fallar ',
                          style: TextStyle(
                            color: Color.fromRGBO(69, 107, 255, 1),
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notification_important,
                      size: 32,
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Herhangi bir bildiriminiz yok",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(45),
                child: Column(
                  children: <Widget>[
                    containerImageSpecify(
                      "assets/ask_fali/bg1.jpg",
                      "Standart a??k fal??n??za bakt??rmak i??in t??klay??n??z. A??k fal?? en ??zel fallardan biri ve ??o??u ki??inin merak duydu??u bir fal t??r??d??r.",
                      askFaliFunc,
                      context,
                      "Standart A??k Fal??",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    containerImageSpecify(
                        "assets/ask_fali/lovecard.jpeg",
                        "Gelecek fal??, k??sa vadede gelece??iniz hakk??nda bilgiler verir. En detayl?? bak??lan fallar??m??zdan biridir gelece??iniz hakk??nda ??zel bir soru se??ebilirsiniz.",
                        gelecekFaliFunc,
                        context,
                        "Gelecek Fal??"),
                    SizedBox(
                      height: 20,
                    ),
                    containerImageSpecify(
                        "assets/ask_fali/bg3.jpg",
                        "Genel vadede t??m konular hakk??nda sizi bilgilendiren y??zeysel bak??lan bir fald??r.",
                        gunlukFalFunc,
                        context,
                        "G??nl??k Fal"),
                    SizedBox(
                      height: 20,
                    ),
                    containerImageSpecify(
                        "assets/ask_fali/bg2.jpg",
                        "Astrolojide, her insan??n do??du??u anda g??ky??z??nde yer alan g??k cisimlerinin konumlar??n??n, birbirleriyle yapt??klar?? a????lar??n yer ald?????? haritaya denir. ",
                        dogumHaritasiFunc,
                        context,
                        "Do??um Haritas??"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void askFaliFunc() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => QuestionPage()));
  }

  void gunlukFalFunc() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GunlukFal()));
  }

  void dogumHaritasiFunc() {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateNotification,
    );
    popup.show(
      title: 'Do??um Haritas?? Yak??nda',
      content:
          '??zerinde uzmanlar??m??z ile birlikte ??al????t??????m??z bu uygulamam??z yak??n zamanda siz de??erli kullan??c??lar??m??za ??cretiz olarak sunulacakt??r. L??tfen bizi desteklemeyi unutmay??n??z.',
      actions: [
        popup.button(
          label: 'Kapat',
          onPressed: Navigator.of(context).pop,
        ),
      ],
      // bool barrierDismissible = false,
      // Widget close,
    );
  }

  void gelecekFaliFunc() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GelecekFali()));
  }
}
