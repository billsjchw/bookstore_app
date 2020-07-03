import 'package:bookstore_app/dto/consignee.dart';
import 'package:flutter/material.dart';

class OrderItemsInMyCartDto {
  final Consignee consignee;
  final String paymentMethod;

  OrderItemsInMyCartDto({
    @required this.consignee,
    @required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'consignee': consignee.toJson(),
      'paymentMethod': paymentMethod,
    };
  }
}
