class Menu {
  final int id;
  final int businessId;
  final String name;
  final String description;
  final int price;

  Menu({
    required this.id,
    required this.businessId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['menu_id'],
      businessId: json['business_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }
}
