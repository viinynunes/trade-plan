// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderStatusEnumAdapter extends TypeAdapter<OrderStatusEnum> {
  @override
  final int typeId = 4;

  @override
  OrderStatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OrderStatusEnum.open;
      case 1:
        return OrderStatusEnum.closed;
      default:
        return OrderStatusEnum.open;
    }
  }

  @override
  void write(BinaryWriter writer, OrderStatusEnum obj) {
    switch (obj) {
      case OrderStatusEnum.open:
        writer.writeByte(0);
        break;
      case OrderStatusEnum.closed:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
