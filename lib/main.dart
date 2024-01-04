import 'package:e_commerce_app/data/auth/auth_repo.dart';
import 'package:e_commerce_app/provider/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'config/routes.dart';
import 'data/database.dart';
import 'data/products/products_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  _initializeHiveStorage();
  runApp(const MyApp());
}
Future<void> _initializeHiveStorage() async {
  HiveStorage(await Hive.openBox(HiveKeys.appBox));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(375, 812),

        builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppControllers(),),
            ChangeNotifierProvider(create: (context) => AuthApi(),),
            ChangeNotifierProvider(create: (context) => ProductApi(),),
          ],
          child: MaterialApp(
            title: 'Shop App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RouteGenerator.splashPage,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        );
      }
    );
  }
}