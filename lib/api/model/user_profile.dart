class UserProfile {
  final int? individualId;
  final DateTime? createdAt;
  final String? name;
  final String? email;
  String? password;
  final String? location;
  final String? phoneNumber;

  UserProfile({
    this.individualId,
    this.createdAt,
    this.name,
    this.email,
    this.password,
    this.location,
    this.phoneNumber,
  });

  factory UserProfile.fromIndividualJson(Map<String, dynamic> json) {
    return UserProfile(
      individualId: json['individual_id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      email: json['email'],
      password: json['password'],
      location: json['city'],
      phoneNumber: json['phone_number'],
    );
  }

  factory UserProfile.fromVendorJson(Map<String, dynamic> json) {
    return UserProfile(
      individualId: json['vendor_id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['vendor_name'],
      email: json['vendor_email'],
      password: json['vendor_password'],
      location: json['vendor_city'],
      phoneNumber: json['vendor_phone_number'],
    );
  }

  factory UserProfile.fromRecycleCompanyJson(Map<String, dynamic> json) {
    return UserProfile(
      individualId: json['recycling_company_id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['company_name'],
      email: json['company_email'],
      password: json['company_password'],
      location: json['company_city'],
      phoneNumber: json['company_phone_number'],
    );
  }

  Map<String, dynamic> toIndividualJson() {
    return {
      'name': name,
      'email': email,
      'city': location,
      'phone_number': phoneNumber,
    };
  }

  Map<String, dynamic> toVendorJson() {
    return {
      'vendor_name': name,
      'vendor_email': email,
      'vendor_city': location,
      'vendor_phone_number': phoneNumber,
    };
  }

  Map<String, dynamic> toRecycleCompanyJson() {
    return {
      'company_name': name,
      'company_email': email,
      'company_password': password,
      'company_city': location,
      'company_phone_number': phoneNumber,
    };
  }
}
