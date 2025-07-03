// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemTypeAdapter extends TypeAdapter<CartItemType> {
  @override
  final int typeId = 2;

  @override
  CartItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CartItemType.product;
      case 1:
        return CartItemType.service;
      case 2:
        return CartItemType.package;
      case 3:
        return CartItemType.productAndService;
      default:
        return CartItemType.product;
    }
  }

  @override
  void write(BinaryWriter writer, CartItemType obj) {
    switch (obj) {
      case CartItemType.product:
        writer.writeByte(0);
        break;
      case CartItemType.service:
        writer.writeByte(1);
        break;
      case CartItemType.package:
        writer.writeByte(2);
        break;
      case CartItemType.productAndService:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
