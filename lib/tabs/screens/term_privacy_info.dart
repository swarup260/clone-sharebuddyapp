import 'package:flutter/material.dart';

class TermPrivacyTab extends StatelessWidget {
  final Widget child;

  TermPrivacyTab({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Term and Privacy Policy"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Text(
                "1. Introduction",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                  "1.1 The Android Software Development Kit (referred to in the License Agreement as the 'SDK' and specifically including the Android system files, packaged APIs, and Google APIs add-ons) is licensed to you subject to the terms of the License Agreement. The License Agreement forms a legally binding contract between you and Google in relation to your use of the SDK."),
              SizedBox(
                height: 4,
              ),
              Text(
                  '1.2 "Android" means the Android software stack for devices, as made available under the Android Open Source Project, which is located at the following URL: http://source.android.com/, as updated from time to time.'),
              SizedBox(
                height: 4,
              ),
              Text(
                  '1.3 A "compatible implementation" means any Android device that (i) complies with the Android Compatibility Definition document, which can be found at the Android compatibility website (http://source.android.com/compatibility) and which may be updated from time to time; and (ii) successfully passes the Android Compatibility Test Suite (CTS).'),
              SizedBox(
                height: 4,
              ),
              Text(
                  '1.4 "Google" means Google LLC, a Delaware corporation with principal place of business at 1600 Amphitheatre Parkway, Mountain View, CA 94043, United States.'),
              SizedBox(
                height: 4,
              ),
              Text(
                "2. Accepting this License Agreement",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                  "1.1 The Android Software Development Kit (referred to in the License Agreement as the 'SDK' and specifically including the Android system files, packaged APIs, and Google APIs add-ons) is licensed to you subject to the terms of the License Agreement. The License Agreement forms a legally binding contract between you and Google in relation to your use of the SDK."),
              SizedBox(
                height: 4,
              ),
              Text(
                  '1.2 "Android" means the Android software stack for devices, as made available under the Android Open Source Project, which is located at the following URL: http://source.android.com/, as updated from time to time.'),
              SizedBox(
                height: 4,
              ),
              Text(
                  '1.3 A "compatible implementation" means any Android device that (i) complies with the Android Compatibility Definition document, which can be found at the Android compatibility website (http://source.android.com/compatibility) and which may be updated from time to time; and (ii) successfully passes the Android Compatibility Test Suite (CTS).'),
              SizedBox(
                height: 4,
              ),
              Text(
                  '1.4 "Google" means Google LLC, a Delaware corporation with principal place of business at 1600 Amphitheatre Parkway, Mountain View, CA 94043, United States.'),
              SizedBox(
                height: 4,
              )
            ],
          ),
        ));
  }
}
