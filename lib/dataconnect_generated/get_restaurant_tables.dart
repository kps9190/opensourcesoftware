part of 'generated.dart';

class GetRestaurantTablesVariablesBuilder {
  String restaurantId;

  final FirebaseDataConnect _dataConnect;
  GetRestaurantTablesVariablesBuilder(this._dataConnect, {required  this.restaurantId,});
  Deserializer<GetRestaurantTablesData> dataDeserializer = (dynamic json)  => GetRestaurantTablesData.fromJson(jsonDecode(json));
  Serializer<GetRestaurantTablesVariables> varsSerializer = (GetRestaurantTablesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRestaurantTablesData, GetRestaurantTablesVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetRestaurantTablesData, GetRestaurantTablesVariables> ref() {
    GetRestaurantTablesVariables vars= GetRestaurantTablesVariables(restaurantId: restaurantId,);
    return _dataConnect.query("GetRestaurantTables", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetRestaurantTablesTables {
  final String id;
  final int tableNumber;
  final int capacity;
  final String? locationDescription;
  GetRestaurantTablesTables.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  tableNumber = nativeFromJson<int>(json['tableNumber']),
  capacity = nativeFromJson<int>(json['capacity']),
  locationDescription = json['locationDescription'] == null ? null : nativeFromJson<String>(json['locationDescription']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRestaurantTablesTables otherTyped = other as GetRestaurantTablesTables;
    return id == otherTyped.id && 
    tableNumber == otherTyped.tableNumber && 
    capacity == otherTyped.capacity && 
    locationDescription == otherTyped.locationDescription;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, tableNumber.hashCode, capacity.hashCode, locationDescription.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['tableNumber'] = nativeToJson<int>(tableNumber);
    json['capacity'] = nativeToJson<int>(capacity);
    if (locationDescription != null) {
      json['locationDescription'] = nativeToJson<String?>(locationDescription);
    }
    return json;
  }

  GetRestaurantTablesTables({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    this.locationDescription,
  });
}

@immutable
class GetRestaurantTablesData {
  final List<GetRestaurantTablesTables> tables;
  GetRestaurantTablesData.fromJson(dynamic json):
  
  tables = (json['tables'] as List<dynamic>)
        .map((e) => GetRestaurantTablesTables.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRestaurantTablesData otherTyped = other as GetRestaurantTablesData;
    return tables == otherTyped.tables;
    
  }
  @override
  int get hashCode => tables.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tables'] = tables.map((e) => e.toJson()).toList();
    return json;
  }

  GetRestaurantTablesData({
    required this.tables,
  });
}

@immutable
class GetRestaurantTablesVariables {
  final String restaurantId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRestaurantTablesVariables.fromJson(Map<String, dynamic> json):
  
  restaurantId = nativeFromJson<String>(json['restaurantId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRestaurantTablesVariables otherTyped = other as GetRestaurantTablesVariables;
    return restaurantId == otherTyped.restaurantId;
    
  }
  @override
  int get hashCode => restaurantId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['restaurantId'] = nativeToJson<String>(restaurantId);
    return json;
  }

  GetRestaurantTablesVariables({
    required this.restaurantId,
  });
}

