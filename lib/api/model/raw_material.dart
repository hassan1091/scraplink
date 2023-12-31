import 'package:scraplink/api/model/user_profile.dart';
import 'package:scraplink/shared_preferences.dart';

class RawMaterial {
  final int? id;
  final DateTime? createdAt;
  final dynamic fkVendorId;
  final String? type;
  final String? description;

  RawMaterial({
    this.id,
    this.createdAt,
    this.fkVendorId,
    this.type,
    this.description,
  });

  factory RawMaterial.fromJson(Map<String, dynamic> json) {
    return RawMaterial(
      id: json['raw_material_id'],
      createdAt: DateTime.parse(json['created_at']),
      fkVendorId: json['fk_vendor_id'] is num
          ? json['fk_vendor_id']
          : UserProfile.fromVendorJson(json['fk_vendor_id']),
      type: json['type'],
      description: json['description'],
    );
  }

  Future<Map<String, dynamic>> toJson() async => {
        'fk_vendor_id': (await AppLocalStorage.getString(AppStorageKey.id)),
        'type': type,
        'description': description,
      };
}
