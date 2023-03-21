// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_result_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderResultStatusAdapter extends TypeAdapter<OrderResultStatus> {
  @override
  final int typeId = 3;

  @override
  OrderResultStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OrderResultStatus.win;
      case 1:
        return OrderResultStatus.loss;
      case 2:
        return OrderResultStatus.tie;
      default:
        return OrderResultStatus.win;
    }
  }

  @override
  void write(BinaryWriter writer, OrderResultStatus obj) {
    switch (obj) {
      case OrderResultStatus.win:
        writer.writeByte(0);
        break;
      case OrderResultStatus.loss:
        writer.writeByte(1);
        break;
      case OrderResultStatus.tie:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderResultStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
