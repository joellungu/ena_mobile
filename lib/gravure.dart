import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gravure_controller.dart';

class Gravure extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Gravure();
  }
}

class _Gravure extends State<Gravure> with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //
  List l = ["Agent", "Eleve"];
  //
  late TabController _controller = TabController(length: 2, vsync: this);
  //
  CalendrierController controller = Get.find();

  @override
  void initState() {
    //
    controller.agents();
    controller.eleves();
    //
    super.initState();
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ENA gravure"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              height: 50,
              child: TabBar(
                isScrollable: true,
                controller: _controller,
                indicatorWeight: 1,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                //indicator: BoxDecoration(),
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.shade800,
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                tabs: List.generate(2, (index) {
                  return Tab(
                    text: "${l[index]}",
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Obx(
                () => TabBarView(
                  controller: _controller,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children:
                            List.generate(controller.l1.value.length, (index) {
                          return ListTile(
                            onTap: () {
                              //
                            },
                            leading: const Icon(Icons.person),
                            title: Text(
                                "${controller.l1[index]['nom']}  ${controller.l1[index]['postnom']}"),
                            subtitle:
                                Text("${controller.l1[index]['matricule']}"),
                          );
                        }),
                      ),
                    ),
                    Container(
                      //color: Colors.green,
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children:
                            List.generate(controller.l2.value.length, (index) {
                          //print(l[index]);
                          return ListTile(
                            onTap: () {
                              //
                              //
                            },
                            leading: const Icon(Icons.person),
                            title: Text(
                                "${controller.l2[index]['nom']}  ${controller.l2[index]['postnom']}"),
                            subtitle:
                                Text("${controller.l2[index]['telephone']}"),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
