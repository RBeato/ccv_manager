import 'dart:convert';

class DevilCostume {
  int id;
  String size;
  int quantity;

  DevilCostume({required this.id, required this.size, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size,
      'quantity': quantity,
    };
  }

  factory DevilCostume.fromMap(Map<String, dynamic> map) {
    return DevilCostume(
      id: map['id'] ?? '',
      size: map['size'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevilCostume.fromJson(String source) =>
      DevilCostume.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevilCostume(id: $id, size: $size, quantity: $quantity)';
  }
}
