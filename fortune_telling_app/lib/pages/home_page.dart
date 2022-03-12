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
                          'Falinna Ücretsiz',
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
                      "Standart aşk falınıza baktırmak için tıklayınız. Aşk falı en özel fallardan biri ve çoğu kişinin merak duyduğu bir fal türüdür.",
                      askFaliFunc,
                      context,
                      "Standart Aşk Falı",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    containerImageSpecify(
                        "assets/ask_fali/lovecard.jpeg",
                        "Gelecek falı, kısa vadede geleceğiniz hakkında bilgiler verir. En detaylı bakılan fallarımızdan biridir geleceğiniz hakkında özel bir soru seçebilirsiniz.",
                        gelecekFaliFunc,
                        context,
                        "Gelecek Falı"),
                    SizedBox(
                      height: 20,
                    ),
                    containerImageSpecify(
                        "assets/ask_fali/bg3.jpg",
                        "Genel vadede tüm konular hakkında sizi bilgilendiren yüzeysel bakılan bir faldır.",
                        gunlukFalFunc,
                        context,
                        "Günlük Fal"),
                    SizedBox(
                      height: 20,
                    ),
                    containerImageSpecify(
                        "assets/ask_fali/bg2.jpg",
                        "Astrolojide, her insanın doğduğu anda gökyüzünde yer alan gök cisimlerinin konumlarının, birbirleriyle yaptıkları açıların yer aldığı haritaya denir. ",
                        dogumHaritasiFunc,
                        context,
                        "Doğum Haritası"),
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
      title: 'Doğum Haritası Yakında',
      content:
          'Üzerinde uzmanlarımız ile birlikte çalıştığımız bu uygulamamız yakın zamanda siz değerli kullanıcılarımıza ücretiz olarak sunulacaktır. Lütfen bizi desteklemeyi unutmayınız.',
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
