import 'package:scraplink/api/model/car.dart';
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

  Future<void> register(Individual individual) async {
    final response = await Supabase.instance.client
        .from('individual')
        .insert(individual.toJson())
        .select('*')
        .single();
    AppLocalStorage.setString(AppStorageKey.id,
        Individual.fromJson(response).individualId.toString());
  }

  Future<void> sellCar(Car car) async {
    car.individualId =
        int.parse((await AppLocalStorage.getString(AppStorageKey.id))!);
    final response = await Supabase.instance.client
        .from('individual_salvage_car')
        .insert(car.toJson());
    if (response == null) throw Exception("Failed to add car");
  }
}
