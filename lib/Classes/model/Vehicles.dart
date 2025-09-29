import 'package:my_app/Classes/model/User.dart';

class Vehicle {
  final int id;
  final String uuid;
  final int userId;
  final String make;
  final String model;
  final int year;
  final String fuelType;
  final String category;
  final String transmission;
  final int seatingCapacity;
  final String condition;
  final int engine;
  final String price;
  final String length;
  final String width;
  final String height;
  final String description;
  final String street;
  final String city;
  final String address;
  final String link;
  final List<String> imageUrls;
  final String status;
  final String isApproved;
  final String createdAt;
  final String updatedAt;
  final User user;

  Vehicle({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.category,
    required this.transmission,
    required this.seatingCapacity,
    required this.condition,
    required this.engine,
    required this.price,
    required this.length,
    required this.width,
    required this.height,
    required this.description,
    required this.street,
    required this.city,
    required this.address,
    required this.link,
    required this.imageUrls,
    required this.status,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      userId: json['user_id'] as int,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      fuelType: json['fuel_type'] as String,
      category: json['category'] as String,
      transmission: json['transmission'] as String,
      seatingCapacity: json['seating_capacity'] as int,
      condition: json['condition'] as String,
      engine: json['engine'] as int,
      price: json['price'] as String,
      length: json['length'] as String,
      width: json['width'] as String,
      height: json['height'] as String,
      description: json['description'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      link: json['link'] as String,
      imageUrls: List<String>.from(json['image_urls']),
      status: json['status'] as String,
      isApproved: json['is_approved'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

