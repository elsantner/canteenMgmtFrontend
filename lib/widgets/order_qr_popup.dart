import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/order.dart';

class OrderQrPopup extends StatelessWidget {
  const OrderQrPopup({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Some Order'),
      content: SizedBox(
        width: 200,
        child: QrImage(
          data: 'canteen-mgmt-order:${order.id}',
        ),
      ),
    );
  }
}