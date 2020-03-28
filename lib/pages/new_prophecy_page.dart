import 'package:flutter/material.dart';

import '../pages/prophecy_info_page.dart';

import '../dependencies/language_path_dependecies.dart';
import '../handlers/api.dart';
import '../handlers/language_change.dart';
import '../handlers/zodiac.dart';
import '../handlers/user_data.dart';

class NewProphecyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewProphecyPageState();
  }
}

class _NewProphecyPageState extends State<NewProphecyPage> {
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic> responseData = {};
  Map langData = langHandler.changeLang;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditController = TextEditingController();

  @override
  initState() {
    super.initState();
    setState(() {
      zodiacData.targetDate = selectedDate;
      zodiacData.targetZodiacForAPi;
    });
  }

  Widget _buildTextFromFieldForName() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: langData[newProphecyFullName],
          filled: true,
          fillColor: Colors.white,
        ),
        controller: _nameEditController,
        validator: (String value) {
          if (value.isEmpty) {
            return langData[nameRequired];
          }
        },
        keyboardType: TextInputType.text,
        onSaved: (String value) {
          userData.userName = value;
        },
      ),
    );
  }

  Widget _buildTextStyle(String text) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      child: Text(langData[newProphecyDateButton]),
      onPressed: isLoading == false
          ? () async {
              final DateTime picked = await showDatePicker(
                context: context,
                locale: Locale(langData[localeLower], langData[localeUpper]),
                initialDate: selectedDate,
                firstDate: DateTime(1970),
                lastDate: DateTime(2100),
              );
              if (picked != null && picked != selectedDate)
                setState(() {
                  selectedDate = picked;
                  zodiacData.targetDate = picked;
                  zodiacData.targetZodiacForAPi;
                });
            }
          : () {},
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 40,
        child: Text(langData[newProphecySubmitButton]),
      ),
      onPressed: () {
        _submitFormData();
      },
    );
  }

  void _submitFormData() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();
    await apiHandler.getData().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ProphecyInfoPage(value, false)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: langHandler.chosenLang == 'עברית'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(langData[newProphecyTitle]),
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
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTextStyle(langData[newProphecyTextName]),
                      _buildTextFromFieldForName(),
                      Divider(),
                      _buildTextStyle(langData[newProphecyTextBirthday]),
                      _buildDatePicker(),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(selectedDate.day.toString() +
                            '-' +
                            selectedDate.month.toString() +
                            '-' +
                            selectedDate.year.toString()),
                      ),
                      Divider(),
                      isLoading == false
                          ? _buildSubmitButton()
                          : Container(
                              padding: EdgeInsets.all(5.0),
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
