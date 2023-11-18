import 'dart:io';
import 'dart:math';

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

  Future<void> sellCar(Car car, String imagePath) async {
    car.individualId =
        int.parse((await AppLocalStorage.getString(AppStorageKey.id))!);
    car.imageUrl = (await _uploadImage(imagePath));
    await Supabase.instance.client
        .from('individual_salvage_car')
        .insert(car.toJson());
  }

  Future<String> _uploadImage(String imagePath, {bool isPart = false}) async {
    String imageUrl = _generateUniqueFileName(imagePath);
    await Supabase.instance.client.storage
        .from(isPart ? "part" : "car")
        .upload(imageUrl, File(imagePath));
    return Supabase.instance.client.storage
        .from(isPart ? "part" : "car")
        .getPublicUrl(imageUrl);
  }

  String _generateUniqueFileName(String imagePath) =>
      '${DateTime.now().toUtc().toIso8601String()}-${List.generate(6, (_) => Random().nextInt(36).toString()).join()}-${imagePath.split('/').last.replaceAll(RegExp(r'[^\w\s\-.]'), '_')}'
          .replaceAll(" ", "");
}
