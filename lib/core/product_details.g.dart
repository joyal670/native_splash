// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDetailsAdapter extends TypeAdapter<ProductDetails> {
  @override
  final int typeId = 3;

  @override
  ProductDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDetails();
  }

  @override
  void write(BinaryWriter writer, ProductDetails obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
