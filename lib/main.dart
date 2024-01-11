import 'package:e_commerce_app/data/auth/auth_repo.dart';
import 'package:e_commerce_app/provider/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'config/routes.dart';
import 'data/localDB/database.dart';
import 'data/products/products_api.dart';
import 'models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>(HiveKeys.user);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
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