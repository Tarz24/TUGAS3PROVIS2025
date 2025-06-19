class ProfileModel {
  // 1. Properti Class (menggunakan camelCase untuk nama variabel di Dart)
  final String id;
  final String? firstName; // Dibuat nullable jika bisa kosong
  final String? lastName;  // Dibuat nullable jika bisa kosong
  final DateTime? updatedAt;
  final bool? isAdmin;

  // 2. Constructor untuk membuat object ProfileModel secara manual
  ProfileModel({
    required this.id,
    this.firstName,
    this.lastName,
    required this.updatedAt,
    required this.isAdmin,
  });

  // 3. Factory constructor untuk membuat object dari data JSON (Map) dari Supabase
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String?, // Baca 'first_name' dari JSON
      lastName: json['last_name'] as String?,   // Baca 'last_name' dari JSON
      updatedAt: json['updated_at'] == null 
          ? null 
          : DateTime.parse(json['updated_at'] as String),

      isAdmin: json['is_admin'] as bool?,
    );
  }

  // 4. Method untuk mengubah object ProfileModel kembali menjadi JSON (Map)
  // Berguna saat Anda ingin mengirim data ke Supabase (insert atau update)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'updated_at': updatedAt?.toIso8601String(), // Konversi DateTime ke String
      'is_admin': isAdmin,
    };
  }
}