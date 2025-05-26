// Example Order model:
class Order {
  final String id;
  final String description;
  final DateTime date;

  Order({required this.id, required this.description, required this.date});

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'date': date.toIso8601String(),
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        description: json['description'],
        date: DateTime.parse(json['date']),
      );
}
