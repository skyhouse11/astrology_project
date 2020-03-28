import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../handlers/firebase.dart';
import '../handlers/user_data.dart';
import '../handlers/zodiac.dart';
import '../handlers/language_change.dart';
import '../dependencies/language_path_dependecies.dart';
import '../models/prophecy_data_model.dart';

class ApiDataHandler {
  Map langData;
  final String userIdAndApiKeyEncoded =
      'NjA0MzY3OjI2ZjU2NmFmYzQ5MjI1YzU4YTBkNWIyM2Q4YmE2ZmMz';
  Map<String, dynamic> responseData;
  Map decodedResponse;
  http.Response response;
  String tempData;
  ProphecyData prophecyData;

  Future<ProphecyData> getData() async {
    response = await http.post(
      'https://json.astrologyapi.com/v1/sun_sign_prediction/daily/${zodiacData.targetZodiac}',
      headers: {
        "Content-Type": 'application/json',
        "authorization": "Basic " + userIdAndApiKeyEncoded,
      },
    ).then((value) async {
      responseData = jsonDecode(value.body);
      prophecyData = ProphecyData(
        mapData: responseData,
        name: userData.userName,
        dateOfBirth: zodiacData.targetDate.day.toString() +
            '-' +
            zodiacData.targetDate.month.toString() +
            '-' +
            zodiacData.targetDate.year.toString(),
      );

      await firebaseHandler.sendProphecyData(prophecyData);
      await setDataFields(data: responseData);
    });

    return prophecyData;
  }

  Future<Map<String, dynamic>> setDataFields({Map data}) async {
    langData = langHandler.changeLang;

    // print(data);

    tempData = data['prediction']['personal_life'] +
        ' / ' +
        data['prediction']['health'] +
        ' / ' +
        data['prediction']['profession'] +
        ' / ' +
        data['prediction']['luck'] +
        ' / ' +
        data['prediction']['emotions'] +
        ' / ' +
        data['prediction']['travel'];

    response = await http.post(
        'https://translation.googleapis.com/language/translate/v2?target=${langData[localeLower]}&key=AIzaSyBBL9ye3GNuDVA8Vb-JuZ1XKcf-VFtR-JM&q=$tempData');
    decodedResponse = jsonDecode(response.body);
    tempData = decodedResponse['data']['translations'][0]['translatedText'];

    data['prediction']['personal_life'] = tempData.split(' / ')[0];
    data['prediction']['health'] = tempData.split(' / ')[1];
    data['prediction']['profession'] = tempData.split(' / ')[2];
    data['prediction']['luck'] = tempData.split(' / ')[3];
    data['prediction']['emotions'] = tempData.split(' / ')[4];
    data['prediction']['travel'] = tempData.split(' / ')[5];

    return data;
  }
}

ApiDataHandler apiHandler = new ApiDataHandler();
