// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationModelAdapter extends TypeAdapter<OperationModel> {
  @override
  final int typeId = 1;

  @override
  OperationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OperationModel(
      id: fields[0] as int?,
      defaultStopLoss: fields[2] as double?,
      defaultExpectedTakeProfit: fields[3] as double?,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OperationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.defaultStopLoss)
      ..writeByte(3)
      ..write(obj.defaultExpectedTakeProfit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
