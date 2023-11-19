class ScrapPart {
  final int? partId;
  final DateTime? createdAt;
  final int? fkPartCategory;
  final String? name;
  final String? description;
  final String? make;
  final String? model;
  final String? year;
  final double? price;
  final int? fkVendorId;
  final String? imageUrl;
  final String? category;

  ScrapPart({
    this.partId,
    this.createdAt,
    this.fkPartCategory,
    this.name,
    this.description,
    this.make,
    this.model,
    this.year,
    this.price,
    this.fkVendorId,
    this.imageUrl,
    this.category,
  });

  factory ScrapPart.fromJson(Map<String, dynamic> json) {
    return ScrapPart(
      partId: json['part_id'],
      createdAt: DateTime.parse(json['created_at']),
      fkPartCategory: json['fk_part_category'],
      name: json['part_name'],
      description: json['part_description'],
      make: json['part_make'],
      model: json['part_model'],
      year: json['part_year'],
      price: json['part_price']!.toDouble(),
      fkVendorId: json['fk_vendor_id'],
      imageUrl: json['image_url'],
      category: json['part_category_name'],
    );
  }
}
