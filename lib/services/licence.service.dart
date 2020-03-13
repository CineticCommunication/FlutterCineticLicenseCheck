import 'package:http/http.dart' as http;


/// Service gèrant les licenses
class LicenceService {
  /// Vérifie la validité d'une licence
  /// returns => true si licence est valide
  static Future<bool> verifierLicence(String licence) async {
    String url = "https://api.cinetic.app/v1.0/licence/" + licence;

    return await http.get(url, headers: {
      'content-type': 'application/json',
    }).then((response) async {
      switch (response.statusCode) {
        case 200: 
          return true;
          break;

        default:
          return false;
          break;
      }
    });
  }
}