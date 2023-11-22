import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/constants.dart';
import 'package:scraplink/shared_preferences.dart';

class ScrapPart {
  final int? id;
  final DateTime? createdAt;
  final int? fkPartCategory;
  final String? name;
  final String? description;
  final String? make;
  final String? model;
  final String? year;
  final num? price;
  final UserProfile? vendor;
  String? imageUrl;
  final String? category;

  ScrapPart({
    this.id,
    this.createdAt,
    this.fkPartCategory,
    this.name,
    this.description,
    this.make,
    this.model,
    this.year,
    this.price,
    this.vendor,
    this.imageUrl,
    this.category,
  });

  factory ScrapPart.fromJson(Map<String, dynamic> json) {
    return ScrapPart(
      id: json['part_id'],
      createdAt: DateTime.parse(json['created_at']),
      fkPartCategory: (json['fk_part_category'] is Map<String, dynamic>)
          ? json['fk_part_category']["part_category_id"]
          : json['fk_part_category'],
      name: json['part_name'],
      description: json['part_description'],
      make: json['part_make'],
      model: json['part_model'],
      year: json['part_year'],
      price: json['part_price'],
      vendor: UserProfile.fromVendorJson(json['fk_vendor_id']),
      imageUrl: json['image_url'],
      category: json['part_category_name'],
    );
  }

  Future<Map<String, dynamic>> toJson() async => {
        'fk_part_category': Constants.partCategory.indexOf(category!) + 1,
        'part_name': name,
        'part_description': description,
        'part_make': make,
        'part_model': model,
        'part_year': year,
        'part_price': price,
        'fk_vendor_id': (await AppLocalStorage.getString(AppStorageKey.id)),
        'image_url': imageUrl,
      };
}
