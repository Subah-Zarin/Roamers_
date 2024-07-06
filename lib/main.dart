import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:roamers/firebase_options.dart';
import 'package:roamers/homepage/homepage.dart';
import 'package:roamers/login/login.dart';
import 'package:roamers/login/registration.dart';
import 'package:roamers/pages/tourist_details_page.dart';
import 'package:roamers/welcomePage/welcomepage.dart';
import 'Setting/setting.dart';
import 'homepage/FavoritesPage.dart';
import 'homepage/communitypage.dart';
import 'homepage/favorites_provider.dart';
import 'homepage/profile.dart';
import 'models/tourist_attraction_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'name here',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'welcome',
        routes: {
          'welcome': (context) => welcomepage(),
          'login': (context) => login(),
          'register': (context) => registration(),
          'homepage': (context) => HomePage(),
          'profile': (context) => profile(),
          'communitypage': (context) => communitypage(),
          'FavoritesPage': (context) => FavoritesPage(),
          'tourist_details': (context) => TouristDetailsPage(
            attraction: ModalRoute.of(context)!.settings.arguments as TouristAttraction,
          ),
          'Setting': (context) => Setting(),
        },
      ),
    ),
  );
}

