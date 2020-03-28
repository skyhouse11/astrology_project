import 'package:flutter/material.dart';

import '../pages/prophecy_info_page.dart';

import '../dependencies/language_path_dependecies.dart';
import '../handlers/api.dart';
import '../handlers/language_change.dart';
import '../handlers/user_data.dart';
import '../handlers/firebase.dart';
import '../models/prophecy_data_model.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  Map langData = langHandler.changeLang;
  final String userId = userData.userId;
  ProphecyData decodedData;
  ProphecyData dataToSend;
  List extractedData = [];
  List dataValue = [];
  List keyValue = [];

  @override
  initState() {
    super.initState();
    firebaseHandler.getAllProphecyData().then((value) {
      setState(() {
        extractedData = value;
      });
    });
  }

  Widget _buildCard(ProphecyData dataToShow) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(dataToShow.name),
                subtitle: Text(
                  '${langData[dateOfProphecy]}: ${dataToShow.predictionDate}\n${langData[dateOfBirth]}: ${dataToShow.dateOfBirth}',
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        child: Text(langData[historyDetailsButton]),
                      ),
                      onPressed: () {
                        _onPressedCardButton(dataToShow);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedCardButton(ProphecyData dataToShow) {
    apiHandler.setDataFields(data: dataToShow.mapData).then((value) {
      setState(() {
        dataToSend = ProphecyData(
            mapData: value,
            name: dataToShow.name,
            dateOfBirth: dataToShow.dateOfBirth);
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProphecyInfoPage(dataToSend, true),
        ),
      );
    });
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        decodedData = ProphecyData(
            mapData: new Map.from(extractedData[index]['data']),
            name: extractedData[index]['name'],
            dateOfBirth: extractedData[index]['date_of_birth']);
        return _buildCard(decodedData);
      },
      itemCount: extractedData != null ? extractedData.length : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: langHandler.chosenLang == 'עברית'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(langData[historyTitle]),
        ),
        body: Container(
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
          child: extractedData != null
              ? _buildList()
              : Center(
                  child: Text('No History!'),
                ),
        ),
      ),
    );
  }
}
