import 'dart:convert';

import 'package:get/get.dart';

import 'main.dart';

class MainController extends GetxController {
  //

  CalendrierConnexion calendrierConnexion = CalendrierConnexion();
  //
  presence(Map<String, dynamic> p) async {
    Response response = await calendrierConnexion.presence(p);
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      Get.back();
      Get.snackbar("Success", "${response.bodyString}",
          duration: Duration(seconds: 5));
    } else {
      //
      Get.back();
      Get.snackbar("Erreur", "Code d'erreur: ${response.statusCode}",
          duration: Duration(seconds: 5));
    }
  }

  check() async {
    Response response = await calendrierConnexion.check();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      //
      Get.back();
      Get.snackbar("Success", "Enregistrement éffectué avec succé!");
    } else {
      print(response.body);
      //
      Get.back();
      Get.snackbar(
          "Erreur", "Information: ${response.body} \n ${response.statusCode}");
    }
  }
}

class CalendrierConnexion extends GetConnect {
  //http://localhost:8080
  Future<Response> presence(Map<String, dynamic> p) async => await post(
        "$url/presence/save",
        jsonEncode(p),
      );

  Future<Response> check() async => await get(
        "$url/agent/all",
      );
}
