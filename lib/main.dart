import 'package:beamer/beamer.dart';
import 'services/canteen_service.dart';
import 'screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'cubits/order_cubit.dart';
import 'screens/dish_service_demo.dart';
import 'screens/home.dart';
import 'screens/my_orders.dart';
import 'screens/order_demo.dart';
import 'screens/qr_demo.dart';
import 'screens/qr_scanner.dart';
import 'screens/single_order.dart';
import 'services/dish_service.dart';
import 'services/order_service.dart';

void main() {
  GetIt.I.registerFactory<DishService>(() => DishService());
  GetIt.I.registerFactory<CanteenService>(() => CanteenService());
  // lazy, as the orders depend on the user.
  GetIt.I.registerLazySingleton<OrderService>(() => OrderService());
  GetIt.I.registerLazySingleton<OrderCubit>(() => OrderCubit());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final beamerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // Return either Widgets or BeamPages if more customization is needed
        '/': (context, state, data) => const HomeScreen(),
        '/dish': (context, state, data) => const DishDemoScreen(),
        '/qr-demo': (context, state, data) =>
            QrDemoScreen(scanValue: data is String? ? data : null),
        '/qr-scan': (context, state, data) => const QrScannerScreen(),
        '/admin': (context, state, data) => const AdminDashboardScreen(),
        '/': (context, state, data) => const BeamPage(
              title: 'Canteen Management',
              child: HomeScreen(),
            ),
        '/dish': (context, state, data) => const BeamPage(
              title: 'Dish Demo',
              child: DishDemoScreen(),
            ),
        '/order': (context, state, data) => const BeamPage(
              title: 'My Orders',
              key: ValueKey('my-orders'),
              child: MyOrdersScreen(),
            ),
        '/order/:orderId': (context, state, data) {
          var orderId = int.tryParse(state.pathParameters['orderId']!);
          if (orderId == null) {
            context.beamToNamed('/order');
            return const SizedBox();
          }

          return BeamPage(
            // the key is required for flutter to differentiate between similar widgets.
            // necessary, if multiple different widgets of the same type are used in the same place in the widget tree.
            key: ValueKey('order-$orderId'),
            title: 'Order from SomeCanteen',
            child: SingleOrderScreen(orderId: orderId),
          );
        },
        '/new-order': (context, state, data) => const BeamPage(
              title: 'Order from SomeCanteen',
              child: OrderDemoScreen(),
            ),
        '/qr-demo': (context, state, data) => BeamPage(
              title: 'QR Scanner Demo',
              child: QrDemoScreen(scanValue: data is String? ? data : null),
            ),
        '/qr-scan': (context, state, data) => const BeamPage(
              title: 'Scan QR Code',
              child: QrScannerScreen(),
            ),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationParser: BeamerParser(),
      routerDelegate: beamerDelegate,
    );
  }
}
