part of 'generated.dart';

class ListRestaurantsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListRestaurantsVariablesBuilder(this._dataConnect, );
  Deserializer<ListRestaurantsData> dataDeserializer = (dynamic json)  => ListRestaurantsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListRestaurantsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListRestaurantsData, void> ref() {
    
    return _dataConnect.query("ListRestaurants", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListRestaurantsRestaurants {
  final String id;
  final String name;
  final String cuisineType;
  final String city;
  ListRestaurantsRestaurants.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  cuisineType = nativeFromJson<String>(json['cuisineType']),
  city = nativeFromJson<String>(json['city']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRestaurantsRestaurants otherTyped = other as ListRestaurantsRestaurants;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    cuisineType == otherTyped.cuisineType && 
    city == otherTyped.city;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, cuisineType.hashCode, city.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['cuisineType'] = nativeToJson<String>(cuisineType);
    json['city'] = nativeToJson<String>(city);
    return json;
  }

  ListRestaurantsRestaurants({
    required this.id,
    required this.name,
    required this.cuisineType,
    required this.city,
  });
}

@immutable
class ListRestaurantsData {
  final List<ListRestaurantsRestaurants> restaurants;
  ListRestaurantsData.fromJson(dynamic json):
  
  restaurants = (json['restaurants'] as List<dynamic>)
        .map((e) => ListRestaurantsRestaurants.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRestaurantsData otherTyped = other as ListRestaurantsData;
    return restaurants == otherTyped.restaurants;
    
  }
  @override
  int get hashCode => restaurants.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['restaurants'] = restaurants.map((e) => e.toJson()).toList();
    return json;
  }

  ListRestaurantsData({
    required this.restaurants,
  });
}

