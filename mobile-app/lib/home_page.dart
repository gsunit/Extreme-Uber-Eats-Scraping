import 'package:extreme_uber_eats_scraping/screens/map_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extreme Uber Eats Scraping"),
        centerTitle: true,
      ),
      body: MapContent(),
    );
  }
}