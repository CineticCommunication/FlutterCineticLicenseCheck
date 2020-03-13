import 'dart:async';

import 'package:FlutterCineticLicenseCheck/services/licence.service.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlutterLicenseCheck());

class FlutterLicenseCheck extends StatelessWidget {
  // FlutterLicenseCheck({Key key, this.body, this.licence}) : super(key: key);

  final Widget body;
  final String licence;

  final State<dynamic> state;

  bool actif = true;

  FlutterLicenseCheck({Key key, this.body, this.licence, this.state}) : super(key: key) {
    verifierLicence();
    horloge();
  }

  /// Vérification de la licence
  void verifierLicence() async {
    await LicenceService.verifierLicence(licence).then((valide) {
      if (!valide) {
        state.setState(() {
          actif = valide;
        });
      }
    });
  }

  void horloge() async {
    const temps = const Duration(minutes: 15);
    new Timer.periodic(temps, (Timer t) {
      verifierLicence();
    });
  }


  @override
  Widget build(BuildContext context) {
    return (!actif)
        ? MaterialApp(
            home: Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Votre licence est expirée/ Your license has expired",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Veuillez contacter / Please contact",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "info@cinetic.ca",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(),
                  Container(
                    color: Colors.white,
                    child: Text(
                      ((licence != null) ? licence : "XXXXXXXXXXXXXXXXXXX"),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ))
        : body;
  }

}

