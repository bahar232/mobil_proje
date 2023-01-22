import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobil_ap/message/chatPage.dart';
import 'package:mobil_ap/view_model/main_vm.dart';
import 'package:rate/rate.dart';
import '../view_model/expert_model.dart';

class Uzmanlar extends StatefulWidget {
  const Uzmanlar({super.key});
  @override
  State<Uzmanlar> createState() => _UzmanlarState();
}

class _UzmanlarState extends State<Uzmanlar> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  String name = "";
  @override
  Widget build(BuildContext context) {
    final CollectionReference catRef = _database.collection('categories');
    final CollectionReference catRef1 =
        catRef.doc(Get.find<MainVM>().catRef.value).collection('expert');

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return chatPage(email: '');
              }),
            );
          },
          child: Scaffold(
            body: Center(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Uzman Arama",
                      icon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onChanged: (query) {
                    setState(() {
                      name = query;
                    });
                  },
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: catRef1.orderBy("star", descending: true).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                    if (!asyncSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      List<DocumentSnapshot> expertList =
                          asyncSnapshot.data!.docs;
                      return Flexible(
                          child: ListView.builder(
                              itemCount: expertList.length,
                              itemBuilder: (context, index) {
                                var data = expertList[index].data()
                                    as Map<String, dynamic>;
                                if (name.isEmpty) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(data["name"] ?? ""),
                                      subtitle: Text(data["count"] ?? ""),
                                      leading: CircleAvatar(
                                        child: Image(
                                          image:
                                              AssetImage(data["image"] ?? ""),
                                        ),
                                      ),
                                      trailing: Rate(
                                        initialValue: double.tryParse(
                                                data["star"].toString()) ??
                                            0,
                                        onChange: (value) =>
                                            data["star"] = value.toString(),
                                      ),
                                    ),
                                  );
                                }

                                if (data["name"]
                                    .toString()
                                    .toLowerCase()
                                    .startsWith(name.toLowerCase())) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        data["name"] ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        data["count"] ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: CircleAvatar(
                                        child: Image(
                                          image:
                                              AssetImage(data["image"] ?? ""),
                                        ),
                                      ),
                                      trailing: Rate(
                                        initialValue: double.tryParse(
                                                data["star"].toString()) ??
                                            0,
                                        onChange: (value) =>
                                            data["star"] = value.toString(),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }));
                    }
                  })
            ])),
          ),
        ));
  }
}
