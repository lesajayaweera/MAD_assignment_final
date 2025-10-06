class Order {
  final int id;
  final String orderId;
  final int vehicleId;
  final int buyerId;
  final int sellerId;
  final String finalPrice;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Vehicle vehicle;
  final User buyer;
  final User seller;

  Order({
    required this.id,
    required this.orderId,
    required this.vehicleId,
    required this.buyerId,
    required this.sellerId,
    required this.finalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicle,
    required this.buyer,
    required this.seller,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      orderId: json['orderid'] as String,
      vehicleId: json['vehicle_id'] as int,
      buyerId: json['buyer_id'] as int,
      sellerId: json['seller_id'] as int,
      finalPrice: json['final_price'] as String,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      buyer: User.fromJson(json['buyer'] as Map<String, dynamic>),
      seller: User.fromJson(json['seller'] as Map<String, dynamic>),
    );
  }
}

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
  final List<String> images;
  final String status;
  final String isApproved;
  final String createdAt;
  final String updatedAt;
  final List<String> imageUrls;

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
    required this.images,
    required this.status,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrls,
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
      images: List<String>.from(json['images'] as List),
      status: json['status'] as String,
      isApproved: json['is_approved'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      imageUrls: List<String>.from(json['image_urls'] as List),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? twoFactorConfirmedAt;
  final int? currentTeamId;
  final String? profilePhotoPath;
  final String createdAt;
  final String updatedAt;
  final String role;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      twoFactorConfirmedAt: json['two_factor_confirmed_at'] as String?,
      currentTeamId: json['current_team_id'] as int?,
      profilePhotoPath: json['profile_photo_path'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      role: json['role'] as String,
      profilePhotoUrl: json['profile_photo_url'] as String,
    );
  }
}