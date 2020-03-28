import 'package:flutter/material.dart';

import '../handlers/language_change.dart';
import '../dependencies/language_path_dependecies.dart';
import '../dependencies/routes_paths_dependecies.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String popupValue = langHandler.chosenLang;
  Map<dynamic, dynamic> langData = langHandler.changeLang;

  Widget _raisedButton(String text, String route, IconData icon) {
    return Container(
        margin: EdgeInsets.all(20.0),
        child: RaisedButton.icon(
          icon: Icon(icon),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          label: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            width: 120.0,
            alignment: Alignment.center,
            child: Text(text),
          ),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Directionality(
        textDirection: langHandler.chosenLang == 'עברית'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text(langData[homeTitle]),
            actions: <Widget>[
              PopupMenuButton(
                elevation: 3.2,
                initialValue: langHandler.chosenLang,
                onCanceled: () {
                  print('You have not chossed anything');
                },
                tooltip: 'This is tooltip',
                onSelected: (selected) {
                  setState(() {
                    langHandler.chosenLang = selected;
                    langData = langHandler.changeLang;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return langHandler.langChoices.map<PopupMenuEntry<dynamic>>(
                    (String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList();
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        0.9,
                      ],
                      colors: [
                        Colors.lightBlue[50],
                        Colors.lightBlue[100],
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: FractionalOffset.topCenter,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _raisedButton(langData[newProphecyButton],
                            newProphecyRoute, Icons.storage),
                        _raisedButton(langData[historyButton], historyRoute,
                            Icons.history),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
