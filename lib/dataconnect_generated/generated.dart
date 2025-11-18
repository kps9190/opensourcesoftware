library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_user.dart';

part 'list_restaurants.dart';

part 'update_reservation_notes.dart';

part 'get_restaurant_tables.dart';







class ExampleConnector {
  
  
  CreateUserVariablesBuilder createUser () {
    return CreateUserVariablesBuilder(dataConnect, );
  }
  
  
  ListRestaurantsVariablesBuilder listRestaurants () {
    return ListRestaurantsVariablesBuilder(dataConnect, );
  }
  
  
  UpdateReservationNotesVariablesBuilder updateReservationNotes ({required String id, }) {
    return UpdateReservationNotesVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetRestaurantTablesVariablesBuilder getRestaurantTables ({required String restaurantId, }) {
    return GetRestaurantTablesVariablesBuilder(dataConnect, restaurantId: restaurantId,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'example',
    'tabeling',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
