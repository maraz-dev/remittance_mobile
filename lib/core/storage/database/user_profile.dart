import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserContacts extends HiveObject {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  String? username;
  @HiveField(5)
  String? phoneNumber;
  @HiveField(6)
  String? address;
  @HiveField(7)
  String? email;
}
