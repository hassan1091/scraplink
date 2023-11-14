class Individual {
  final int individualId;
  final DateTime createdAt;
  final String? name;
  final String email;
  final String password;
  final String? city;
  final String? phoneNumber;

  Individual({
    required this.individualId,
    required this.createdAt,
    this.name,
    required this.email,
    required this.password,
    this.city,
    this.phoneNumber,
  });

  factory Individual.fromJson(Map<String, dynamic> json) {
    return Individual(
      individualId: json['individual_id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      email: json['email'],
      password: json['password'],
      city: json['city'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'individual_id': individualId,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'email': email,
      'password': password,
      'city': city,
      'phone_number': phoneNumber,
    };
  }
}
