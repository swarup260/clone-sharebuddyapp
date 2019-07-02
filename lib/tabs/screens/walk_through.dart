import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home.dart';
import '../../models/PageModel.dart';
import '../../widget/page_indicator.dart';
import '../../api/networkManager.dart';
import '../../api/apiEndpoint.dart';

class Walkthrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7fbff),
      body: WalkthroughBody(),
    );
  }
}

class WalkthroughBody extends StatefulWidget {
  WalkthroughBody({Key key}) : super(key: key);

  @override
  WalkthroughBodyState createState() => WalkthroughBodyState();
}

class WalkthroughBodyState extends State<WalkthroughBody> {
  PageController _pageController;
  CrossFadeState _bottomState = CrossFadeState.showFirst;
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    registerUser().then((value) async {
      final SharedPreferences prefs = await getPrefs();
      final getIsregisterUser = prefs.getBool("isregisterUser") ?? false;
      if (!getIsregisterUser) {
        final isregisterUser = await registerUser();
        prefs.setBool("isregisterUser", isregisterUser);
      }
    }).catchError((onError) {
      AlertDialog(
        content: Text("Network Error"),
      );
    });
  }

  Future<bool> registerUser() async {
    final deviceId = await getDeviceIdentity();
    try {
      final result = await ajaxPost(getApiEndpoint(endpoint.register), {
        "deviceId": deviceId,
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "pushTokenId": "testing"
      });
      return result.status;
    } catch (e) {
      return false;
    }
  }

  void _pageListener() {
    if (_pageController.hasClients) {
      setState(() {
        /* if (_pageController.page.toInt() == (pages.length - 1)) {
          _bottomState = CrossFadeState.showSecond;
        } else {
          _bottomState = CrossFadeState.showFirst;
        } */
      });
    }
  }

/* 
CircleAvatar(
                  backgroundColor: Color(0xFFf7fbff),
                  backgroundImage: AssetImage(pages[index].assetImagePath),
                  radius: 125.0,
                )


 */
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100.0),
                Container(
                  height: 250.0,
                  width: 150.0,
                  child: Image.asset(pages[index].assetImagePath),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0, left: 60.0, right: 40.0, bottom: 100.0),
                  child: Text(
                    pages[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
              ],
            );
          },
          onPageChanged: (int index) {
            if (index == (pages.length - 1)) {
              _bottomState = CrossFadeState.showSecond;
            } else {
              _bottomState = CrossFadeState.showFirst;
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 96.0,
            alignment: Alignment.center,
            child: AnimatedCrossFade(
              crossFadeState: _bottomState,
              duration: Duration(milliseconds: 300),
              firstChild: PageIndicators(
                pageController: _pageController,
                pageLength: pages.length,
              ),
              secondChild: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  final SharedPreferences prefs = await getPrefs();
                  prefs.setBool("walkThroughView", true);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 98.0),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageIndicators extends StatelessWidget {
  final PageController pageController;
  final int pageLength;

  const PageIndicators({Key key, this.pageController, this.pageLength})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: PageViewIndicator(
              controller: pageController,
              pageCount: pageLength,
              color: Colors.black,
            )),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              pageController.animateToPage((pageLength - 1),
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 500));
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Skip',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 19.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
