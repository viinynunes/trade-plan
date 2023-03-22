// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaperModelAdapter extends TypeAdapter<PaperModel> {
  @override
  final int typeId = 2;

  @override
  PaperModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaperModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      pointsPerTicks: fields[3] as double,
      moneyByTick: fields[4] as double,
      taxByContract: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PaperModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.taxByContract)
      ..writeByte(3)
      ..write(obj.pointsPerTicks)
      ..writeByte(4)
      ..write(obj.moneyByTick);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaperModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
