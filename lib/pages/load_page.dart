import 'dart:async';

import 'package:flutter/material.dart';

import '../dependencies/routes_paths_dependecies.dart';

class LoadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadPageState();
  }
}

class _LoadPageState extends State<LoadPage> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
