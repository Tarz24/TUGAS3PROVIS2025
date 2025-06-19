import 'package:flutter/foundation.dart';
import 'package:tugas_provis/models/profile_model.dart';
import 'package:tugas_provis/services/supabase_services.dart';

class ProfileViewModel extends ChangeNotifier {
  final _supabaseService = SupabaseService();

  bool _isLoading = false;
  ProfileModel? _profile;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  ProfileModel? get profile => _profile;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    _profile = null;
    notifyListeners();

    try {
      // Panggil service untuk mendapatkan profil
      _profile = await _supabaseService.getProfile();
      print("DEBUG (ViewModel): Hasil dari service adalah -> $_profile");
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Beri tahu UI untuk update
    }
  }
}