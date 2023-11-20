class Vendor {
  int? id;
  DateTime? createdAt;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? location;

  Vendor({
    this.id,
    this.createdAt,
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
    this.location,
  });

  Vendor.fromJson(Map<String, dynamic> map)
      : id = map['vendor_id'],
        createdAt = DateTime.parse(map['created_at']),
        email = map['vendor_email'],
        password = map['vendor_password'],
        name = map['vendor_name'],
        phoneNumber = map['vendor_phone_number'],
        location = map['vendor_city'];

  Map<String, dynamic> toJson() => {
        'vendor_id': id,
        'created_at': createdAt?.toIso8601String(),
        'vendor_email': email,
        'vendor_password': password,
        'vendor_name': name,
        'vendor_phone_number': phoneNumber,
        'vendor_city': location,
      };
}
