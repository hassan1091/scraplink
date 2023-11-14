import 'package:scraplink/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'model/individual.dart';

class ApiService {
  Future<void> login(String email, String password) async {
    final response = await Supabase.instance.client
        .from('individual')
        .select("*")
        .eq("email", email)
        .eq("password", password)
        .single();
    AppLocalStorage.setString(AppStorageKey.id,
        Individual.fromJson(response).individualId.toString());
  }
}
