import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/api/model/user_profile.dart';

class Bid {
  final int? id;
  final dynamic carId;
  final UserProfile? vendor;
  final num? price;
  final String? status;

  Bid({
    this.id,
    this.carId,
    this.vendor,
    this.price,
    this.status,
  });

  factory Bid.fromJson(Map<String, dynamic> json, {isBid = false}) {
    return Bid(
      id: json['salvage_car_order_id'],
      carId: isBid ? Car.fromJson(json['fk_car_id']) : json['fk_car_id'],
      vendor: UserProfile.fromVendorJson(json['fk_vendor_id']),
      price: json['bidding_price'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson(vendorId) {
    return {
      'fk_car_id': carId,
      'fk_vendor_id': vendorId,
      'bidding_price': price,
    };
  }
}

enum BidStatus { accepted, rejected, pending }
