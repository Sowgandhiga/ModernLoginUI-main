// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutputAdapter extends TypeAdapter<Output> {
  @override
  final int typeId = 1;

  @override
  Output read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Output(
      pickup: fields[0] as String,
      drop: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Output obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pickup)
      ..writeByte(1)
      ..write(obj.drop);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutputAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
