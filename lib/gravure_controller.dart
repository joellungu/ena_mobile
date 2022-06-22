import 'dart:convert';

import 'package:get/get.dart';

import 'main.dart';

class CalendrierController extends GetxController {
  //
  RxList l1 = [].obs;
  //
  RxList l2 = [].obs;
  //

  CalendrierConnexion calendrierConnexion = CalendrierConnexion();
  //
  agents() async {
    print("cool 1");
    Response response = await calendrierConnexion.agents();
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      l1.value = response.body;
      print(response.body);
    } else {
      print(response.body);
    }
  }

  eleves() async {
    Response response = await calendrierConnexion.eleves();
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      l1.value = response.body;
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

class CalendrierConnexion extends GetConnect {
  Future<Response> agents() async => await get(
        "$url/agent/all",
      );
  Future<Response> eleves() async => await get(
        "$url/eleve/all",
      );
}
