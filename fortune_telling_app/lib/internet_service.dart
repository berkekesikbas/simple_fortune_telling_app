import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckInternet {
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Bilinmiyor";
  var contentmessage = "Bilinmiyor";

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          //InternetStatus = "Connected to the Internet";
          //contentmessage = "Connected to the Internet";
          //_showDialog(InternetStatus,contentmessage,context);
          break;
        case DataConnectionStatus.disconnected:
          InternetStatus = "İnternet Bağlantı Sorunu";
          contentmessage =
              "Lütfen internet bağlantınızı kontrol edip tekrar deneyin.";
          _showDialog(InternetStatus, contentmessage, context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: new Text("Kapat"))
              ]);
        });
  }
}
