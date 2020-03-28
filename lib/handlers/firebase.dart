import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../handlers/user_data.dart';
import '../handlers/language_change.dart';
import '../models/prophecy_data_model.dart';

class FirebaseHandler {
  FirebaseApp targetApp;

  Future<void> apiSetApp() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'com.company.astrology_project',
      options: const FirebaseOptions(
        googleAppID: '1:590548687560:android:bb30e34291be6cf5',
        gcmSenderID: '590548687560',
        apiKey: 'AIzaSyCeh8LVk31Smr4JAkcOanxgIHe2YRgNUs8',
        projectID: 'com.company.astrology_project',
      ),
    );
    targetApp = app;
    final Firestore firestore = Firestore(app: app);
    await firestore.settings(timestampsInSnapshotsEnabled: true);
  }

  Future<void> sendDefaultLanguage(
      String userIdCollection, String language) async {
    final Firestore firestore = Firestore(app: targetApp);
    await firestore.settings(timestampsInSnapshotsEnabled: true);
    await Firestore.instance
        .collection('users')
        .document(userIdCollection)
        .setData({'defaultLang': language}, merge: true);
  }

  Future<void> sendProphecyData(
    ProphecyData dataToSend,
  ) async {
    final Firestore firestore = Firestore(app: targetApp);
    await firestore.settings(timestampsInSnapshotsEnabled: true);
    await Firestore.instance
        .collection('users')
        .document(userData.userId)
        .collection('history')
        .add({
      'data': dataToSend.mapData,
      'name': dataToSend.name,
      'date_of_birth': dataToSend.dateOfBirth,
    });
  }

  Future<Null> getDefaultData(String userIdCollection) async {
    Map defaultData;
    final Firestore firestore = Firestore(app: targetApp);
    await firestore.settings(timestampsInSnapshotsEnabled: true);
    await Firestore.instance
        .collection('users')
        .document(userIdCollection)
        .get()
        .then((value) {
      defaultData = value.data;
    }).then((value) {
      if (defaultData['defaultLang'] != null) {
        langHandler.chosenLang = defaultData['defaultLang'];
      } else {
        langHandler.chosenLang = 'English';
      }
    });
  }

  Future<List> getAllProphecyData() async {
    List data = [];
    final Firestore firestore = Firestore(app: targetApp);
    await firestore.settings(timestampsInSnapshotsEnabled: true);
    await Firestore.instance
        .collection('users')
        .document(userData.userId)
        .collection('history')
        .getDocuments()
        .then((value) {
      value.documents.forEach((document) async {
        data.add(document.data);
      });
    });
    return data;
  }
}

FirebaseHandler firebaseHandler = new FirebaseHandler();
