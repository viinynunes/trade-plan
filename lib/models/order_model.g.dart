// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 0;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      id: fields[0] as String?,
      operation: fields[6] as OperationModel,
      paper: fields[7] as PaperModel,
      contracts: fields[1] as double,
      enterPoint: fields[2] as double,
      stopLoss: fields[3] as int,
      expectedTakeProfit: fields[4] as int,
      executionTime: fields[5] as DateTime,
      status: fields[8] as OrderStatusEnum,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.contracts)
      ..writeByte(2)
      ..write(obj.enterPoint)
      ..writeByte(3)
      ..write(obj.stopLoss)
      ..writeByte(4)
      ..write(obj.expectedTakeProfit)
      ..writeByte(5)
      ..write(obj.executionTime)
      ..writeByte(6)
      ..write(obj.operation)
      ..writeByte(7)
      ..write(obj.paper)
      ..writeByte(8)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
