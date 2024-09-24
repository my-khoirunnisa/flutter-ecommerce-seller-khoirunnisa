import 'package:image_picker/image_picker.dart';

class RegisterRequestModel {
  // 'name': 'Toko Pancing Sejati',
  // 'email': 'pancing@seller.com',
  // 'password': '12345678',
  // 'phone': '023434344444',
  // 'address': 'sleman',
  // 'country': 'indonesia',
  // 'province': 'DI Yogyakarta',
  // 'city': 'Sleman',
  // 'district': 'Mlati',
  // 'postal_code': '23432'

  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String country;
  final String province;
  final String city;
  final String district;
  final String postalCode;
  final XFile image;
  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.country,
    required this.province,
    required this.city,
    required this.district,
    required this.postalCode,
    required this.image,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'country': country,
      'province': province,
      'city': city,
      'district': district,
      'postal_code': postalCode,
    };
  }
}
