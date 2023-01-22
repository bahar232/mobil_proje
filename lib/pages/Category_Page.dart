import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widget/category_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [Expanded(child: CategoriesWidget())],
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key});

  final CollectionReference catRef =
      FirebaseFirestore.instance.collection('categories');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 244, 160, 160), Colors.white])),
          child: Expanded(
              child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Kategoriler\nSayfası",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(height: 50),
              StreamBuilder<QuerySnapshot>(
                  stream: catRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      // ignore: avoid_print
                      data.forEach(((element) => print(element.data())));
                      return Column(
                        children: [
                          SafeArea(
                              child: CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: false,
                                aspectRatio: 1,
                                enlargeCenterPage: true,
                                viewportFraction: 0.6),
                            items: [
                              ...data
                                  .map((element) => CategoryWidget(
                                      element["catName"],
                                      element["image"],
                                      element["detail"]))
                                  .toList(),
                            ],
                          ))
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          ))),
    );
  }
}
