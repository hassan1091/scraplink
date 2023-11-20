import 'dart:io';
import 'dart:math';

import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/api/model/individual.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/api/model/vendor.dart';
import 'package:scraplink/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<void> updateProfile(individual) async {
    await Supabase.instance.client
        .from('individual')
        .update(individual.toJson())
        .eq("individual_id",
            (await AppLocalStorage.getString(AppStorageKey.id)));
  }

  Future<void> sellCar(Car car, String imagePath) async {
    car.individualId =
        int.parse((await AppLocalStorage.getString(AppStorageKey.id))!);
    car.imageUrl = (await _uploadImage(imagePath));
    await Supabase.instance.client
        .from('individual_salvage_car')
        .insert(car.toJson());
  }

  Future<Individual> getProfile() async {
    final response = await Supabase.instance.client
        .from('individual')
        .select("*")
        .eq("individual_id",
            (await AppLocalStorage.getString(AppStorageKey.id)))
        .single();
    return Individual.fromJson(response);
  }

  Future<List<Car>> getCars() async {
    final response = await Supabase.instance.client
        .from('individual_salvage_car')
        .select("*")
        .eq("fk_individual_id",
            (await AppLocalStorage.getString(AppStorageKey.id)));
    return response.map((json) => Car.fromJson(json)).toList().cast<Car>();
  }

  Future<List<ScrapPart>> getScrapParts(
      {String? make, String? model, String? category, String? year}) async {
    final dynamic response;
    if (make == null) {
      response = await Supabase.instance.client
          .from('scrap_part')
          .select('*, part_category:fk_part_category(part_category_name)');
    } else if (model == null) {
      response = await Supabase.instance.client
          .from('scrap_part')
          .select('*, part_category:fk_part_category(part_category_name)')
          .eq("part_make", make);
    } else {
      response = await Supabase.instance.client
          .from('scrap_part')
          .select('*, fk_part_category:part_category(part_category_name)')
          .eq("part_make", make)
          .eq("part_model", model)
          .eq("part_year", year)
          .eq("fk_part_category:part_category(part_category_name)", category);
    }
    return response
        .map((json) => ScrapPart.fromJson(json))
        .toList()
        .cast<ScrapPart>();
  }

  Future<List<Vendor>> getVendors() async {
    final response = await Supabase.instance.client.from('vendor').select("*");
    return response
        .map((json) => Vendor.fromJson(json))
        .toList()
        .cast<Vendor>();
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
