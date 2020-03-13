import 'dart:async';

import 'package:FlutterCineticLicenseCheck/services/licence.service.dart';
import 'package:flutter/material.dart';

class FlutterLicenseCheck extends StatefulWidget {
  FlutterLicenseCheck(this.licence, this.body);
  Widget body;
  final String licence;
  @override
  _WidgetPrincipalState createState() => _WidgetPrincipalState(licence, body);
}

class _WidgetPrincipalState extends State<FlutterLicenseCheck> {
  bool actif = true;

  Widget body;
  String licence;

  _WidgetPrincipalState(this.licence, this.body) {
    verifierLicence();
    horloge();
  }

  /// Vérification de la licence
  void verifierLicence() async {
    await LicenceService.verifierLicence(licence).then((valide) {
      print("Votre licence est " + ((valide) ? "valide" : "invalide"));
      if (!valide) {
        setState(() {
          actif = valide;
        });
      } else {
        if (!actif) {
          setState(() {
            actif = valide;
          });
        }
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
            home: Stack(
            children: <Widget>[
              body,
              Scaffold(
                backgroundColor: Colors.red.withOpacity(0.80),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Votre licence est expirée / Your license has expired",
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
              ),
            ],
          ))
        : body;
  }
}
