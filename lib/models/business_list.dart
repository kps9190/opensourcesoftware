class BusinessList {
  final int id;
  final int ownerId;
  final String name;
  final String category;
  final String address;
  final String hours;
  final String description;
  final double lat;
  final double lng;

  BusinessList({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.category,
    required this.address,
    required this.hours,
    required this.description,
    required this.lat,
    required this.lng,
  });

  factory BusinessList.fromJson(Map<String, dynamic> json) {
    return BusinessList(
      id: json['business_id'],
      ownerId: json['business_owner_id'],
      name: json['business_name'],
      category: json['business_category'],
      address: json['business_address'],
      hours: json['business_hours'],
      description: json['business_description'],
      lat: (json['business_lat'] as num).toDouble(),
      lng: (json['business_lng'] as num).toDouble(),
    );
  }
}
