import 'geoLoc.dart';

class Restaurants{
String Name;
String Food_Type;
double Stars_count;
int Reviews_Count;
String Price_Range;
String Dining_Style;
String Address;
String Area;
String City;
String Image_Url;
List<String> Payment_Options;
String Reserve_Url;
GeoLoc geoloc;

Restaurants(this.Name, this.Food_Type, this.Stars_count, this.Reviews_Count,
    this.Price_Range, this.Dining_Style, this.Address, this.Area, this.City,
    this.Image_Url, this.Payment_Options, this.Reserve_Url, this.geoloc);

static Restaurants fromMap(Map<String, dynamic> map) {
  return Restaurants(
    map['name'] ?? "",
    map['food_type'] ?? "",
      (map['stars_count'] ?? 0.0).toDouble(),
    map['reviews_count'] ?? 0,
    map['price_range'] ?? "",
    map['dining_style'] ?? "",
    map['address'] ?? "",
    map['area'] ?? "",
    map['city'] ?? "",
    map['image_url'] ?? "",
    List<String>.from(map['payment_options']),
    map['reserve_url'] ?? "",
    GeoLoc.fromMap(map['_geoloc'])
  );
}


}