import 'package:scraplink/api/model/vendor.dart';

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
  final Vendor? vendor;
  final String? imageUrl;
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
      vendor: Vendor.fromJson(json['fk_vendor_id']),
      imageUrl: json['image_url'],
      category: json['part_category_name'],
    );
  }
}
