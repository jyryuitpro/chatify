import 'package:chatify/services/database_service.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.authStateChanges().listen((_user) {
      if(_user != null) {
        print('Logged in');
      } else {
        print('Not Authenticated');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      print(_auth.currentUser);
    } on FirebaseAuthException catch (e) {
      print('Error loggin user into Firebase');
    } catch(e) {
      print(e);
    }
  }
}
