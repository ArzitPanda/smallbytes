import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/core/services/user_service.dart';
import 'package:smallbytes/features/auth/screens/login_screen.dart';
import 'package:smallbytes/features/auth/services/auth_service.dart';
import 'package:smallbytes/features/auth/viewModels/auth_view_model.dart';
import 'package:smallbytes/features/course/screen/self_courses_screen.dart';
import 'package:smallbytes/features/home/screens/home_screen.dart';
import 'package:smallbytes/features/intro/screen/start_screen.dart';
import 'package:smallbytes/features/profileCreate/ProfileViewModel.dart';
import 'package:smallbytes/features/profileCreate/service/ProfileService.dart';



   Account account = Account(AppwriteClient().client);
void main() {
  // UserService userService = UserService();


  WidgetsFlutterBinding.ensureInitialized();

  runApp( const MainApp() );
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
            ),
        home:Consumer<AuthViewModel>(
          builder: (context, authViewModel, _) {
            if (authViewModel.isLoggedIn ==true) {
              return HomeScreen(); // Navigate to HomeScreen if user is logged in
            } else {
              return LoginScreen(); // Navigate to LoginScreen if user is not logged in
            }
          },
        ),
      ),
    );
  
  }
}
