class Business {
  final int businessId;
  final int ownerId;
  final String name;
  final String category;
  final String address;
  final String hours;
  final String description;
  final double lat;
  final double lng;
  final double rating;
  final int reviews;

  Business({
    required this.businessId,
    required this.ownerId,
    required this.name,
    required this.category,
    required this.address,
    required this.hours,
    required this.description,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.reviews,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessId: json['business_id'],
      ownerId: json['business_owner_id'],
      name: json['business_name'],
      category: json['business_category'] ?? "",
      address: json['business_address'],
      hours: json['business_hours'],
      description: json['business_description'],
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
    );
  }
}
