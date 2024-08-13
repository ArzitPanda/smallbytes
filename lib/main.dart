import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/features/auth/services/auth_service.dart';
import 'package:smallbytes/features/auth/viewModels/auth_view_model.dart';
import 'package:smallbytes/features/home/screens/home_screen.dart';
import 'package:smallbytes/features/intro/screen/start_screen.dart';
import 'package:smallbytes/features/profileCreate/ProfileViewModel.dart';
import 'package:smallbytes/features/profileCreate/service/ProfileService.dart';



   Account account = Account(AppwriteClient().client);
void main() {

  WidgetsFlutterBinding.ensureInitialized();
 
  runApp( MainApp()   
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(AuthService(account))),
        ChangeNotifierProvider(create: (_)=>ProfileViewModel(profileService:ProfileService(AppwriteClient().client,)))
      ],
      child: MaterialApp(
        theme: ThemeData.from(
            colorScheme: const ColorScheme.light(),
            textTheme: GoogleFonts.rubikTextTheme()),
        home: Scaffold(
          body: Center(
            child: HomeScreen(),
          ),
        ),
      ),
    );
  
  }
}
