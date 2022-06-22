import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:presence_mobile/gravure.dart';
import 'package:presence_mobile/gravure_controller.dart';
import 'package:presence_mobile/main_controller.dart';

String url = "http://192.168.43.252:8080";

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  //
  CalendrierController calendrierController = Get.put(CalendrierController());
  MainController mainController = Get.put(MainController());
  //
  MyApp1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ena',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  MainController mainController = Get.find();

  @override
  void initState() {
    //print(tag.data);
    Timer(const Duration(seconds: 1), () async {
      bool isAvailable = await NfcManager.instance.isAvailable();
      isAvailable ? load() : print("N'est pas valide!");
    });

    /*
    Get.dialog(
      const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
      name: "Attente...",
    );
    */
    Map<String, dynamic> p = {
      "idUtilisateur": "1234567",
      "dateTime": "${DateTime.now()}"
    };
    //
    //
    super.initState();
  }

  load() async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      //tag.data['ndefformatable']['identifier']
      var e = tag.data['nfca']['identifier'];
      List l = jsonDecode(e.toString());
      String li = "";
      l.forEach((e) => {li = li + "$e"});
      print("Le tag1: $li");
      Map<String, dynamic> m = {"idcarte": "li", "dateTime": ""};
      //print("Le tag1: ${l}");
      //print("Le tag: ${tag.data['nfca']['identifier']}");
      if (DateTime.now().hour > 9 && DateTime.now().hour < 16) {
        messageAlerte();
      } else {
        mainController.presence({
          "idcarte": "$li",
          "lelo":
              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
          "dateArrive": "${DateTime.now()}",
          "dateDepart": DateTime.now().hour > 9 ? "${DateTime.now()}" : "",
        });
      }
    });
  }

  messageAlerte() {
    Get.snackbar("INTERDICTION",
        "DE 9H à 15H LE PRELEVEMENT DE LA PRESENCE EST INTERDIT",
        duration: Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('ENA'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => Gravure());
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                mainController.check();
              },
              icon: Icon(Icons.g_mobiledata_outlined),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 300,
              width: 300,
              child: Image.asset("assets/ena.jpeg"),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Veuillez deposer votre carte ici!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
Long idUtilisateur;
    String dateTime;
*/