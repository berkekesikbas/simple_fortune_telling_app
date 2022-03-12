import 'package:flutter/material.dart';

class CustomPageScaffold2 extends StatelessWidget {
  final void Function() onBackPressed;
  final void Function() onButtonPressed;
  final String buttonTitle;
  final String title;
  final Widget body;
  final Color pageColor;
  final bool hasButton;

  const CustomPageScaffold2(
      {Key key,
      this.onBackPressed,
      this.title,
      this.body,
      this.pageColor,
      this.buttonTitle,
      this.hasButton = true,
      this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Center(
                        child: Text(
                          '$title',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                            color: this.pageColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 16),
                                  child: this.body,
                                ),
                              ),
                              this.hasButton
                                  ? Material(
                                      borderRadius: BorderRadius.circular(16),
                                      color: this.pageColor,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {
                                          this.onButtonPressed();
                                        },
                                        child: Container(
                                          height: 54,
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              '$buttonTitle',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
