import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tugas_provis/models/product_model.dart';
import 'package:tugas_provis/models/profile_model.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // --- FUNGSI LOGIN ---
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Terjadi error tidak dikenal: $e');
    }
  }

  // --- FUNGSI REGISTER ---
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: { // Mengirim metadata untuk disimpan oleh trigger di tabel profiles
          'first_name': firstName,
          'last_name': lastName,
        },
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Terjadi error tidak dikenal: $e');
    }
  }

  // --- FUNGSI LOGOUT ---
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

   // --- FUNGSI AMBIL PROFIL PENGGUNA ---
  Future<ProfileModel?> getProfile() async {
    print("DEBUG (Service): Fungsi getProfile() dimulai.");
    
    final user = _client.auth.currentUser;

    if (user == null) {
      print("DEBUG (Service): KESIMPULAN -> Pengguna tidak login. Proses dihentikan.");
      return null;
    }

    print("DEBUG (Service): User ditemukan, ID: ${user.id}.");
    
    try {
      print("DEBUG (Service): Akan menjalankan query ke Supabase...");
      
      // Kemungkinan besar proses menggantung di baris 'await' di bawah ini
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single(); 
      
      // Jika print di bawah ini muncul, berarti query berhasil
      print("DEBUG (Service): Query ke Supabase BERHASIL. Response: $response");
      return ProfileModel.fromJson(response);

    } catch (e) {
      // Jika ada error dari Supabase, akan tertangkap di sini
      print("DEBUG (Service): Query ke Supabase GAGAL. Error: $e");
      return null;
    }
  }

  // ... (fungsi lain seperti getProfile, getProducts, dll)
  Future<List<ProductModel>> getProducts() async {
    try {
      // Ambil semua data dari tabel 'products'
      final response = await _client.from('products').select();
      
      // Ubah data List<Map> menjadi List<ProductModel>
      final productList = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
          
      return productList;
    } catch (e) {
      throw Exception('Gagal mengambil data produk: $e');
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('id', id)
          .single(); // .single() untuk mengambil satu baris saja
      
      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Gagal mengambil detail produk: $e');
    }
  }
}