import 'dart:io';
import 'dart:math';

import 'package:scraplink/api/model/bid.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/encrypt_data..dart';
import 'package:scraplink/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  Future<void> login(String email, String password, String role) async {
    final response = await Supabase.instance.client
        .from(role)
        .select("${role}_id")
        .eq(
            role == Role.individual.name
                ? "email"
                : role == Role.recycling_company.name
                    ? "company_email"
                    : "${role}_email",
            email)
        .eq(
            role == Role.individual.name
                ? "password"
                : role == Role.recycling_company.name
                    ? "company_password"
                    : "${role}_password",
            EncryptData().encryptData(password))
        .single();
    AppLocalStorage.setString(
        AppStorageKey.id, response["${role}_id"].toString());
    AppLocalStorage.setString(AppStorageKey.role, role);
  }

  Future<void> register(UserProfile profile, String role) async {
    profile.password = EncryptData().encryptData(profile.password!);
    final response = await Supabase.instance.client
        .from(role)
        .insert(role == Role.individual.name
            ? profile.toIndividualJson()
            : role == Role.vendor.name
                ? profile.toVendorJson()
                : profile.toRecycleCompanyJson())
        .select("${role}_id")
        .single();
    AppLocalStorage.setString(
        AppStorageKey.id, response["${role}_id"].toString());
    AppLocalStorage.setString(AppStorageKey.role, role);
  }

  Future<void> updateProfile(UserProfile userProfile) async {
    String currentRole = (await AppLocalStorage.getString(AppStorageKey.role))!;
    await Supabase.instance.client
        .from(currentRole)
        .update(currentRole == Role.individual.name
            ? userProfile.toIndividualJson(isEdit: true)
            : userProfile.toVendorJson(isEdit: true))
        .eq("${currentRole}_id",
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

  Future<void> sellScrapPart(ScrapPart scrapPart, String imagePath) async {
    scrapPart.imageUrl = (await _uploadImage(imagePath, isPart: true));
    await Supabase.instance.client
        .from('scrap_part')
        .insert(await scrapPart.toJson());
  }

  Future<void> deleteScrapPart(int scrapId) async {
    await Supabase.instance.client
        .from('scrap_part')
        .delete()
        .eq("part_id", scrapId)
        .eq("fk_vendor_id",
            (await AppLocalStorage.getString(AppStorageKey.id)));
  }

  Future<void> sellRawMaterial(RawMaterial rawMaterial) async {
    await Supabase.instance.client
        .from('raw_material')
        .insert(await rawMaterial.toJson());
  }

  Future<void> deleteRawMaterial(int materialId) async {
    await Supabase.instance.client
        .from('raw_material')
        .delete()
        .eq("raw_material_id", materialId)
        .eq("fk_vendor_id",
            (await AppLocalStorage.getString(AppStorageKey.id)));
  }

  Future<void> bid(Bid bid) async {
    await Supabase.instance.client.from('salvage_car_order').insert(
        bid.toJson((await AppLocalStorage.getString(AppStorageKey.id))));
  }

  Future<void> accept(Bid bid) async {
    await Supabase.instance.client.from('salvage_car_order').update(
        {"status": BidStatus.accepted.name}).eq("salvage_car_order_id", bid.id);
  }

  Future<void> reject(Bid bid) async {
    await Supabase.instance.client.from('salvage_car_order').update(
        {"status": BidStatus.rejected.name}).eq("salvage_car_order_id", bid.id);
  }

  Future<String> getCarOwnerPhone(carId) async {
    return (await Supabase.instance.client
        .from('individual_salvage_car')
        .select("fk_individual_id(phone_number)")
        .eq("individual_salvage_car_id", carId)
        .single())["fk_individual_id"]["phone_number"];
  }

  Future<UserProfile> getProfile() async {
    String currentRole = (await AppLocalStorage.getString(AppStorageKey.role))!;
    final response = await Supabase.instance.client
        .from(currentRole)
        .select("*")
        .eq("${currentRole}_id",
            (await AppLocalStorage.getString(AppStorageKey.id)))
        .single();
    return currentRole == Role.individual.name
        ? UserProfile.fromIndividualJson(response)
        : UserProfile.fromVendorJson(response);
  }

  Future<List<Car>> getCars(
      {bool isIndividual = true,
      String? make,
      String? model,
      String? location,
      String? year}) async {
    final dynamic response;
    if (isIndividual) {
      response = await Supabase.instance.client
          .from('individual_salvage_car')
          .select("*")
          .eq("fk_individual_id",
              (await AppLocalStorage.getString(AppStorageKey.id)));
    } else if (make == null) {
      response = await Supabase.instance.client
          .from('individual_salvage_car')
          .select("*");
    } else if (model == null) {
      response = await Supabase.instance.client
          .from('individual_salvage_car')
          .select("*")
          .eq('make', make);
    } else {
      response = await Supabase.instance.client
          .from('individual_salvage_car')
          .select("*")
          .eq('make', make)
          .eq('model', model)
          .eq('location', location)
          .eq('year', year);
    }
    return response.map((json) => Car.fromJson(json)).toList().cast<Car>();
  }

  Future<List<ScrapPart>> getScrapParts(
      {bool isInventory = false,
      String? make,
      String? model,
      String? category,
      String? year}) async {
    final dynamic response;
    if (isInventory) {
      response = await Supabase.instance.client
          .from('scrap_part')
          .select(
              '*, part_category:fk_part_category(part_category_name),fk_vendor_id:vendor(*)')
          .eq("fk_vendor_id",
              (await AppLocalStorage.getString(AppStorageKey.id)));
    } else if (make == null) {
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
          .eq("fk_part_category(part_category_name)",
              Constants.partCategory.indexOf(category!) + 1);
    }
    return response
        .map((json) => ScrapPart.fromJson(json))
        .toList()
        .cast<ScrapPart>();
  }

  Future<List<Bid>> getBids(carId) async {
    final dynamic response;
    if (carId == null) {
      response = await Supabase.instance.client
          .from('salvage_car_order')
          .select(
              "*,fk_vendor_id:vendor(*),fk_car_id:individual_salvage_car(*)")
          .eq("fk_vendor_id",
              (await AppLocalStorage.getString(AppStorageKey.id)));
      return response
          .map((json) => Bid.fromJson(json, isBid: true))
          .toList()
          .cast<Bid>();
    } else {
      response = await Supabase.instance.client
          .from('salvage_car_order')
          .select("*,fk_vendor_id:vendor(*)")
          .eq("fk_car_id", carId);
      return response.map((json) => Bid.fromJson(json)).toList().cast<Bid>();
    }
  }

  Future<List<UserProfile>> getVendors() async {
    final response = await Supabase.instance.client.from('vendor').select("*");
    return response
        .map((json) => UserProfile.fromVendorJson(json))
        .toList()
        .cast<UserProfile>();
  }

  Future<List<UserProfile>> getRecycleCompanies() async {
    final response =
        await Supabase.instance.client.from('recycling_company').select("*");
    return response
        .map((json) => UserProfile.fromRecycleCompanyJson(json))
        .toList()
        .cast<UserProfile>();
  }

  Future<List<RawMaterial>> getRawMaterial({bool isInventory = false}) async {
    final dynamic response;
    if (isInventory) {
      response = await Supabase.instance.client
          .from('raw_material')
          .select("*,fk_vendor_id:vendor(*)")
          .eq("fk_vendor_id",
              (await AppLocalStorage.getString(AppStorageKey.id)));
    } else {
      response = await Supabase.instance.client
          .from('raw_material')
          .select("*,fk_vendor_id:vendor(*)");
    }
    return response
        .map((json) => RawMaterial.fromJson(json))
        .toList()
        .cast<RawMaterial>();
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
