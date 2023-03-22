// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closed_order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClosedOrderModelAdapter extends TypeAdapter<ClosedOrderModel> {
  @override
  final int typeId = 5;

  @override
  ClosedOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClosedOrderModel(
      closeTime: fields[9] as DateTime,
      result: fields[10] as OrderResultStatus,
      pointsResult: fields[11] as double,
      moneyResult: fields[12] as double,
      tax: fields[13] as double?,
      operation: fields[6] as OperationModel,
      paper: fields[7] as PaperModel,
      contracts: fields[1] as double,
      enterPoint: fields[2] as double,
      stopLoss: fields[3] as int,
      expectedTakeProfit: fields[4] as int,
      executionTime: fields[5] as DateTime,
      status: fields[8] as OrderStatusEnum,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, ClosedOrderModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(9)
      ..write(obj.closeTime)
      ..writeByte(10)
      ..write(obj.result)
      ..writeByte(11)
      ..write(obj.pointsResult)
      ..writeByte(12)
      ..write(obj.moneyResult)
      ..writeByte(13)
      ..write(obj.tax)
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
      other is ClosedOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
