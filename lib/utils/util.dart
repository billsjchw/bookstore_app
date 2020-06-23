import 'dart:convert';
import 'dart:typed_data';

Uint8List dataUriToBytes(String dataUri) {
  return base64.decode(dataUri.split(',').last);
}

String priceToString(int price) {
  return '¥${(price / 100).toStringAsFixed(2)}';
}

String dateToString(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
}

String stockDescription(int stock) {
  if (stock == 0)
    return '❌ Out of stock';
  else if (stock < 200)
    return '⚠ Low stock';
  else
    return '✔ Sufficient stock';
}
