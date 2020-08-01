class Place {
  String title;
  String lat;
  String long;

  Place({
    this.title,
    this.lat,
    this.long,
  });

  Place.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    lat = json['lat'] as String;
    long = json['long'] as String;
  }
}