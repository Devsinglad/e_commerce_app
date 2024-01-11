// user_model.dart

import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String city;
  @HiveField(2)
  late String password;


  User({
    required this.username,
    required this.password,
    required this.city,
  });
}