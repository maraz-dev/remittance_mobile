// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserContactsAdapter extends TypeAdapter<UserContacts> {
  @override
  final int typeId = 0;

  @override
  UserContacts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserContacts()
      ..id = fields[1] as String?
      ..firstName = fields[2] as String?
      ..lastName = fields[3] as String?
      ..username = fields[4] as String?
      ..phoneNumber = fields[5] as String?
      ..address = fields[6] as String?
      ..email = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, UserContacts obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserContactsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
