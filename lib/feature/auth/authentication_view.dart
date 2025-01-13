import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: firebase.FirebaseUIActions(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              if (state.user != null) {
                Navigator.pushNamed(context, '/completeProfile');
              }
            }),
          ],
          child: SizedBox(
            height: context.general.mediaSize.height,
            child: Center(
              child: Theme(
                data: context.general.appTheme,
                child: Padding(
                  padding: context.padding.normal,
                  child: firebase.LoginView(
                    action: AuthAction.signIn,
                    providers: firebase.FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
