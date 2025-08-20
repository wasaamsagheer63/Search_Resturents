  class GeoLoc{
    double lat;
    double lng;

    GeoLoc(this.lat, this.lng);

    static GeoLoc fromMap(Map<String, dynamic> map) {
      return GeoLoc(

        map['lat'] ?? 0,
        map['lng'] ?? 0,

      );
    }
  }