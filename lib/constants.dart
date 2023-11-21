import 'package:flutter/material.dart';
import 'package:scraplink/api/model/bid.dart';
import 'package:scraplink/api/model/car.dart';
import 'package:scraplink/api/model/scrap_part.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
  static const List<String> regions = [
    'Riyadh',
    'Makkah',
    'Madinah',
    'Eastern Province',
    'Asir',
    'Tabuk',
    'Hail',
    'Northern Borders',
    'Jazan',
    'Najran',
    'Al Bahah',
    'Al Jawf',
    'Qassim'
  ];

  static const Map<String, List<String>> models = {
    "Toyota": [
      "Corolla",
      "Avalon",
      "Camry",
      "FJCruiser",
      "Hilux",
      "Innova",
      "LandCruiser",
      "RAV4",
      "Yaris",
      "Avanza",
      "Rush",
      "Highlander",
      "LandCruiser_PickUp",
      "Prado",
    ],
    "Ford": [
      "Taurus",
      "Expedition",
      "Explorer",
      "F-150",
      "Figo",
      "Edge",
      "CrownVictoria",
      "Ranger",
      "Figo",
      "Territory",
    ],
    "Honda": [
      "Civic",
      "Accord",
      "CR-V",
      "Pilot",
      "Odyssey",
      "City",
      "HR-V",
    ],
    "Hyundai": [
      "Sonata",
      "Kona",
      "Accent",
      "Azera",
      "Elantra",
      "SantaFe",
      "Palisade",
      "Veloster",
      "Creta",
      "Tucson",
    ],
    "Kia": [
      "Cadenza",
      "Cerato",
      "Rio",
      "K5",
      "Carnival",
      "Pegas",
      "Sorento",
      "Telluride",
      "K8",
      "Sportage",
    ],
    "Jeep": [
      "Cherokee",
      "Compass",
      "GrandCherokee",
      "Wrangler",
      "Gladiator",
    ]
  };

  static const List<String> partCategory = [
    "Engine  Components",
    "Drivetrain",
    "Suspension and Steering",
    "Body and Frame",
    "Interior Components",
    "Wheels and Tires",
    "Sensors and Modules"
  ];

  static void contact(phoneNumber, context,
      {ScrapPart? scrapPart, Bid? bid, Car? car}) {
    Uri url = Uri.parse("https://wa.me/$phoneNumber?text=");
    if (scrapPart != null) {
      url = Uri.parse("https://wa.me/$phoneNumber?text="
          "Hi, ${scrapPart.vendor!.name}I am a customer from ScrapLink app: "
          "\nI want to buy \nName:${scrapPart.name}. "
          "\nDescription:${scrapPart.description}. "
          "\nPrice:${scrapPart.price}.");
    } else if (bid != null) {
      url = Uri.parse("https://wa.me/$phoneNumber?text="
          "Hi ${bid.vendor!.name},I accept your biding in ScrapLink app: "
          "In car:${car!.name}."
          "\nDescription:${car.description}. "
          "\nYour bidding is:${bid.price}.");
    }
    launchUrl(url, mode: LaunchMode.externalApplication).then((value) {
      if (!value) {
        showDialog(
            context: context,
            builder: (_) =>
                const AlertDialog(title: Text("Could not launch WhatsApp.")));
      }
    });
  }
}

// ignore: constant_identifier_names
enum Role { individual, vendor, recycling_company }
