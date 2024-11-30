import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart'; // new
import 'package:flutter/material.dart';
import 'menu_page.dart';

///                         Login Page
/// +--------------------------------------------------------------+
/// | The Login Page is the thing first thing a user sees when     |
/// | the open the application. The user passes in some            |
/// | credentials for user authentication via Google Auth to sign  |
/// | in to the application. This after authentication is          |
/// | complete the user is brought to the Menu page.               |
/// +--------------------------------------------------------------+

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              GoogleProvider(
                  clientId:
                      "675305167171-5iarv505kpfg0hd343rrmcrog2jtkk0r.apps.googleusercontent.com"), // new
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/beekeepr_logo.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Beekeepr, please sign in!')
                    : const Text('Welcome to Beekeepr, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/beekeepr_logo.png'),
                ),
              );
            },
          );
        }

        return const MenuPage();
      },
    );
  }
}
