class Station {
  bool isRadio;
  String name;
  String source;
  String logo;
  String artwork;

  Station({this.isRadio, this.name, this.source, this.logo, this.artwork});

  Map<String, dynamic> toMap() {
    var map = {
      "isRadio": isRadio,
      "name": name,
      "source": source,
      "logo": logo,
      "artwork": artwork
    };
    return map;
  }

  Station.fromJson(Map<String, dynamic> json) {
    isRadio = json['isRadio'];
    name = json['name'];
    source = json['source'];
    logo = json['logo'];
    artwork = json['artwork'];
  }
}
