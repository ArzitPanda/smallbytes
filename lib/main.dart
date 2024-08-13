import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/features/auth/services/auth_service.dart';
import 'package:smallbytes/features/auth/viewModels/auth_view_model.dart';
import 'package:smallbytes/features/intro/screen/start_screen.dart';
import 'package:smallbytes/features/profileCreate/ProfileViewModel.dart';
import 'package:smallbytes/features/profileCreate/service/ProfileService.dart';
import 'package:smallbytes/features/profileCreate/user_profile.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Account account = Account(AppwriteClient().client);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(AuthService(account))),
        ChangeNotifierProvider(create: (_)=>ProfileViewModel(profileService:ProfileService(AppwriteClient().client,)))
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: const ColorScheme.light(),
          textTheme: GoogleFonts.rubikTextTheme()),
      home: Scaffold(
        body: Center(
          child: StartScreen(),
        ),
      ),
    );
  }
}
