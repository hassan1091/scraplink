class Car {
  int? carId;
  DateTime createdAt;
  int? individualId;
  String? make;
  String? model;
  String? year;
  String? location;
  String? name;
  String? description;

  Car({
    this.carId,
    required this.createdAt,
    this.individualId,
    this.make,
    this.model,
    this.year,
    this.location,
    this.name,
    this.description,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carId: json['individualSalvageCarId'],
      createdAt: DateTime.parse(json['createdAt']),
      individualId: json['fkIndividualId'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      location: json['location'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fkIndividualId': individualId,
      'make': make,
      'model': model,
      'year': year,
      'location': location,
      'name': name,
      'description': description,
    };
  }
}
