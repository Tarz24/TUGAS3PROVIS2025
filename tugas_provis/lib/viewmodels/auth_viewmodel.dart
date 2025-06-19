import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tugas_provis/services/supabase_services.dart';

class AuthViewModel extends ChangeNotifier {
  final _supabaseService = SupabaseService();
  final _supabase = Supabase.instance.client;

  bool _isLoading = false;
  User? _user;
  String? _errorMessage;
  late final StreamSubscription<AuthState> _authStateSubscription;

  bool get isLoading => _isLoading;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  AuthViewModel() {
    // Memantau status login secara realtime
    _authStateSubscription = _supabase.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  // --- MEKANISME LOGIN ---
  Future<void> signInWithEmailPassword(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _supabaseService.signInWithEmailPassword(email: email, password: password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- MEKANISME REGISTER ---
  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _supabaseService.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  // --- MEKANISME LOGOUT ---
  Future<void> signOut() async {
    await _supabaseService.signOut();
  }
}