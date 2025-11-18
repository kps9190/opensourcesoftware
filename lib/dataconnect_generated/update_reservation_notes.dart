part of 'generated.dart';

class UpdateReservationNotesVariablesBuilder {
  String id;
  Optional<String> _notes = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateReservationNotesVariablesBuilder notes(String? t) {
   _notes.value = t;
   return this;
  }

  UpdateReservationNotesVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateReservationNotesData> dataDeserializer = (dynamic json)  => UpdateReservationNotesData.fromJson(jsonDecode(json));
  Serializer<UpdateReservationNotesVariables> varsSerializer = (UpdateReservationNotesVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateReservationNotesData, UpdateReservationNotesVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateReservationNotesData, UpdateReservationNotesVariables> ref() {
    UpdateReservationNotesVariables vars= UpdateReservationNotesVariables(id: id,notes: _notes,);
    return _dataConnect.mutation("UpdateReservationNotes", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateReservationNotesReservationUpdate {
  final String id;
  UpdateReservationNotesReservationUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateReservationNotesReservationUpdate otherTyped = other as UpdateReservationNotesReservationUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateReservationNotesReservationUpdate({
    required this.id,
  });
}

@immutable
class UpdateReservationNotesData {
  final UpdateReservationNotesReservationUpdate? reservation_update;
  UpdateReservationNotesData.fromJson(dynamic json):
  
  reservation_update = json['reservation_update'] == null ? null : UpdateReservationNotesReservationUpdate.fromJson(json['reservation_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateReservationNotesData otherTyped = other as UpdateReservationNotesData;
    return reservation_update == otherTyped.reservation_update;
    
  }
  @override
  int get hashCode => reservation_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (reservation_update != null) {
      json['reservation_update'] = reservation_update!.toJson();
    }
    return json;
  }

  UpdateReservationNotesData({
    this.reservation_update,
  });
}

@immutable
class UpdateReservationNotesVariables {
  final String id;
  late final Optional<String>notes;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateReservationNotesVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    notes = Optional.optional(nativeFromJson, nativeToJson);
    notes.value = json['notes'] == null ? null : nativeFromJson<String>(json['notes']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateReservationNotesVariables otherTyped = other as UpdateReservationNotesVariables;
    return id == otherTyped.id && 
    notes == otherTyped.notes;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, notes.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(notes.state == OptionalState.set) {
      json['notes'] = notes.toJson();
    }
    return json;
  }

  UpdateReservationNotesVariables({
    required this.id,
    required this.notes,
  });
}

