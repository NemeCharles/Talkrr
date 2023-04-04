// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoggedInUserDataAdapter extends TypeAdapter<LoggedInUserData> {
  @override
  final int typeId = 0;

  @override
  LoggedInUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoggedInUserData(
      userName: fields[0] as String,
      email: fields[1] as String,
      uid: fields[3] as String,
      profilePhoto: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoggedInUserData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.uid)
      ..writeByte(4)
      ..write(obj.profilePhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedInUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
