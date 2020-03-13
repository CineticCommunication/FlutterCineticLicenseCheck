import 'package:flutter/material.dart';

void main() => runApp(FlutterLicenseCheck());

class FlutterLicenseCheck extends StatefulWidget {
  FlutterLicenseCheck({Key key, this.body}) : super(key: key);

  final Widget body;

  @override
  _LicenseCheckState createState() => _LicenseCheckState(body);
}

class _LicenseCheckState extends State<FlutterLicenseCheck> {
  double screenWidth;
  double screenHeight;

  _LicenseCheckState(this.body);

  final Widget body;

  final bool actif = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        (!actif)
            ? Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.75)),
                child: Center(
                  child: Text(
                    "Votre license est expirée/ Your license has expired",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            : Container(),
        body,
      ],
    );
  }
}
