import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobil_ap/view_model/main_vm.dart';

import '../pages/HomePage.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatefulWidget {
  String name, image, description;
  CategoryWidget(this.name, this.image, this.description, {super.key});
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        var response = await FirebaseFirestore.instance
            .collection("categories")
            .where("catName", isEqualTo: widget.name)
            .get();
        if (response.docs.isNotEmpty) {
          Get.find<MainVM>().catRef.value = response.docs.first.id;
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        }
      },
      child: Stack(
        children: [
          Flexible(
            child: Card(
              elevation: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(widget.image),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        widget.name,
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        widget.description,
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
