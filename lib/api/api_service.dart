import 'dart:developer';

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
    Individual individual = Individual.fromJson(response);
    log(individual.name.toString());
    AppLocalStorage.setString(
        AppStorageKey.id, individual.individualId.toString());
  }
}
