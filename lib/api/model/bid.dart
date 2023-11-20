import 'package:scraplink/api/model/vendor.dart';

class Bid {
  final int? id;
  final int? carId;
  final Vendor? vendor;
  final num? price;
  final String? status;

  Bid({
    this.id,
    this.carId,
    this.vendor,
    this.price,
    this.status,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      id: json['salvage_car_order_id'],
      carId: json['fk_car_id'],
      vendor: Vendor.fromJson(json['fk_vendor_id']),
      price: json['bidding_price'],
      status: json['status'],
    );
  }
}
