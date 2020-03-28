class ProphecyData {
  Map<String, dynamic> mapData;
  String name;
  String dateOfBirth;

  get predictionDate => mapData['prediction_date'];

  get personalLife => mapData['prediction']['personal_life'];

  get health => mapData['prediction']['health'];

  get profession => mapData['prediction']['profession'];

  get luck => mapData['prediction']['luck'];

  get emotions => mapData['prediction']['emotions'];

  get travel => mapData['prediction']['travel'];

  ProphecyData({this.mapData, this.name, this.dateOfBirth});
}
