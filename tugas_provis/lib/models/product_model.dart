class ProductModel {
  final int id;
  final String? name;
  final String? description;
  final double? pricePerDay;
  final String? imageUrl;
  final List<String> tags;
  final int? quantityAvailable;
  final Map<String, dynamic>? variants;

  ProductModel({
    required this.id,
    this.name,
    this.description,
    this.pricePerDay,
    this.imageUrl,
    required this.tags,
    this.quantityAvailable,
    this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      // Konversi tipe 'num' (bisa int atau double) ke double, aman dari null
      pricePerDay: (json['price_per_day'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      // Konversi array dari Supabase (_text) menjadi List<String> di Dart
      // '?? []' memastikan jika data null, kita dapat list kosong, bukan error.
      tags: List<String>.from(json['tags'] ?? []),
      quantityAvailable: json['quantity_available'] as int?,
      // Tipe 'jsonb' dari Supabase langsung menjadi Map di Dart
      variants: json['variants'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price_per_day': pricePerDay,
      'image_url': imageUrl,
      'tags': tags,
      'quantity_available': quantityAvailable,
      'variants': variants,
    };
  }
}