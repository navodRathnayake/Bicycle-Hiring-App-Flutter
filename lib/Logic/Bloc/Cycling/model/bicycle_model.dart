library bicycle_model;

final class Bicycle {
  final String bicycleID;
  final String bicycleType;
  final String station;
  final String height;
  final String weight;
  final String manufacturedDate;

  const Bicycle({
    this.bicycleID = '',
    this.bicycleType = '',
    this.station = '',
    this.height = '',
    this.weight = '',
    this.manufacturedDate = '',
  });

  @override
  String toString() {
    return """{
      bicycleID : $bicycleID,
      bicycleType : $bicycleType,
      station : $station,
      height : $height,
      weight : $weight,
      manufacturedDate : $manufacturedDate,
    }""";
  }
}
