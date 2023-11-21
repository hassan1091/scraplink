import 'dart:io';
import 'dart:math';

import 'package:scraplink/api/model/bid.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/api/model/vendor.dart';
import 'package:scraplink/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  Future<void> login(String email, String password, String role) async {
    final response = await Supabase.instance.client
        .from(role)
        .select("${role}_id")
        .eq("email", email)
        .eq("password", password)
        .single();

    AppLocalStorage.setString(
        AppStorageKey.id, response["${role}_id"].toString());
  }

  Future<void> register(UserProfile individual) async {
    final response = await Supabase.instance.client
        .from('individual')
        .insert(individual.toIndividualJson())
        .select('*')
        .single();
    AppLocalStorage.setString(AppStorageKey.id,
        UserProfile.fromIndividualJson(response).individualId.toString());
  }

  Future<void> updateProfile(individual) async {
    await Supabase.instance.client
        .from('individual')
        .update(individual.toIndividualJson())
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

  Future<void> accept(Bid bid) async {
    await Supabase.instance.client.from('salvage_car_order').update(
        {"status": BidStatus.accepted.name}).eq("salvage_car_order_id", bid.id);
  }

  Future<void> reject(Bid bid) async {
    await Supabase.instance.client.from('salvage_car_order').update(
        {"status": BidStatus.rejected.name}).eq("salvage_car_order_id", bid.id);
  }

  Future<UserProfile> getProfile() async {
    final response = await Supabase.instance.client
        .from('individual')
        .select("*")
        .eq("individual_id",
            (await AppLocalStorage.getString(AppStorageKey.id)))
        .single();
    return UserProfile.fromIndividualJson(response);
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
      response = await Supabase.instance.client.from('scrap_part').select(
          '*, part_category:fk_part_category(part_category_name),fk_vendor_id:vendor(*)');
    } else if (model == null) {
      response = await Supabase.instance.client
          .from('scrap_part')
          .select(
              '*, part_category:fk_part_category(part_category_name),fk_vendor_id:vendor(*)')
          .eq("part_make", make);
    } else {
      response = await Supabase.instance.client
          .from('scrap_part')
          .select(
              '*, fk_part_category:part_category(part_category_name),fk_vendor_id:vendor(*)')
          .eq("part_make", make)
          .eq("part_model", model)
          .eq("part_year", year)
          .eq("fk_part_category.part_category_name", category!);
    }
    return response
        .map((json) => ScrapPart.fromJson(json))
        .toList()
        .cast<ScrapPart>();
  }

  Future<List<Bid>> getBids(carId) async {
    final response = await Supabase.instance.client
        .from('salvage_car_order')
        .select("*,fk_vendor_id:vendor(*)")
        .eq("fk_car_id", carId);
    return response.map((json) => Bid.fromJson(json)).toList().cast<Bid>();
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
