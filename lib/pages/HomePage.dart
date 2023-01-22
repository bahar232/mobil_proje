// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mobil_ap/pages/Expert_Page.dart';
import 'package:mobil_ap/widget/icon_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 244, 160, 160),
          title: const Text("Uzmanlar"),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ],
        ),
        body: Column(
          children: const [Expanded(child: Uzmanlar())],
        ));
  }
}
