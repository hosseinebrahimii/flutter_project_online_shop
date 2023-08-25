// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchasedProductAdapter extends TypeAdapter<PurchasedProduct> {
  @override
  final int typeId = 1;

  @override
  PurchasedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchasedProduct(
      product: fields[0] as Product,
      productColor: fields[1] as Color,
      productColorName: fields[2] as String,
      productStorage: fields[3] as String,
      initialPrice: fields[4] as int,
      finalPrice: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PurchasedProduct obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.productColor)
      ..writeByte(2)
      ..write(obj.productColorName)
      ..writeByte(3)
      ..write(obj.productStorage)
      ..writeByte(4)
      ..write(obj.initialPrice)
      ..writeByte(5)
      ..write(obj.finalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchasedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
