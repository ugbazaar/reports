class AppDataModel{
  List<DataModel> appDataModel = [];
  AppDataModel.fromJson(Map<String, dynamic> parsedJson){
    if(parsedJson.containsKey("1")){
      appDataModel.add(DataModel.fromJson(parsedJson["1"], "1"),);
    }
    if(parsedJson.containsKey("7")){
      appDataModel.add(DataModel.fromJson(parsedJson["7"], "7"));
    }
    if(parsedJson.containsKey("30")){
      appDataModel.add(DataModel.fromJson(parsedJson["30"], "30"));
    }
    if(parsedJson.containsKey("90")){
      appDataModel.add(DataModel.fromJson(parsedJson["90"], "90"));
    }
  }
}
class DataModel {
  String id;
  Year lastYear;
  Year thisYear;
  Diff difference;

  DataModel.fromJson(Map<String, dynamic> parsedJson, _id){
      id = _id;
      lastYear = Year.fromJson(parsedJson["lastYear"]);
      thisYear = Year.fromJson(parsedJson["thisYear"]);
      difference = Diff.fromJson(parsedJson["diff"]);
    
  }
}

class Year {
  int createdCount;
  int createdAmount;
  int deliveredCount;
  int deliveredAmount;
  Year.fromJson(Map<String, dynamic> parsedJson) {
    createdCount = parsedJson["createdCount"];
    createdAmount = parsedJson["createdAmount"];
    deliveredCount = parsedJson["deliveredCount"];
    deliveredAmount = parsedJson["deliveredAmount"];
  }
}

class Diff {
  DiffCount createdCount;
  DiffCount createdAmount;
  DiffCount deliveredCount;
  DiffCount deliveredAmount;

  Diff.fromJson(Map<String, dynamic> parsedJson) {
    createdCount = DiffCount.fromJson(parsedJson["createdCount"]);
    createdAmount = DiffCount.fromJson(parsedJson["createdAmount"]);
    deliveredCount = DiffCount.fromJson(parsedJson["deliveredCount"]);
    deliveredAmount = DiffCount.fromJson(parsedJson["deliveredAmount"]);
  }
}

class DiffCount {
  String sign;
  double percent;

  DiffCount.fromJson(Map<String, dynamic> parsedJson) {
    sign = parsedJson["sign"];
    percent = parsedJson["percent"].toDouble();
  }
}
