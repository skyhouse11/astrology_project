import 'package:flutter/material.dart';

import '../handlers/language_change.dart';
import '../dependencies/language_path_dependecies.dart';
import '../dependencies/routes_paths_dependecies.dart';
import '../models/prophecy_data_model.dart';

class ProphecyInfoPage extends StatelessWidget {
  final ProphecyData prophecyData;
  final Map langData = langHandler.changeLang;
  final bool fromHistory;

  ProphecyInfoPage(this.prophecyData, this.fromHistory);

  Widget _buildTitleListElement(String date) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.my_location),
          title: Text(prophecyData.name),
          subtitle: Text(
            '${langData[dateOfProphecy]}: ${prophecyData.predictionDate}\n${langData[dateOfBirth]}: ${prophecyData.dateOfBirth}',
          ),
        ),
      ],
    );
  }

  Widget _buildListElement(String title, String text) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(title.toUpperCase()),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(text),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text(langData[prophecyBackButton]),
        onPressed: () {
          fromHistory == false
              ? Navigator.pushReplacementNamed(context, homeRoute)
              : Navigator.pushReplacementNamed(context, historyRoute);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        fromHistory == false
            ? Navigator.pushReplacementNamed(context, homeRoute)
            : Navigator.pushReplacementNamed(context, historyRoute);
      },
      child: Directionality(
        textDirection: langHandler.chosenLang == 'עברית'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: Text(langData[prophecyInfoTitle]),
          ),
          body: Stack(
            children: <Widget>[
              Container(
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
                padding: EdgeInsets.all(10.0),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildTitleListElement(
                      prophecyData.mapData['prediction_date'],
                    ),
                    _buildListElement(
                        langData[personalLife], prophecyData.personalLife),
                    _buildListElement(langData[health], prophecyData.health),
                    _buildListElement(
                        langData[profession], prophecyData.profession),
                    _buildListElement(langData[luck], prophecyData.luck),
                    _buildListElement(
                        langData[emotions], prophecyData.emotions),
                    _buildListElement(langData[travel], prophecyData.travel),
                    _buildActionButton(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
