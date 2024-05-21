import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talk_in_web/presentation/screens/home_screen.dart';
import 'package:talk_in_web/services/data_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class AuthService extends ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  final auth = FirebaseAuth.instance;

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   clientId: '150306616826-4brf4ovgpu8c0vu3ritqpppthd3adnbu.apps.googleusercontent.com',
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  void createAnAccount(BuildContext context,String name,String email,String password) async{
    setLoading(true);
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    if(userCredential.user!=null){
      bool isUserAdded = await DataService().addUserToFirebase(context,userCredential.user!.uid, name, email, password);
      if(isUserAdded){
        setLoading(false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      }else{
        setLoading(false);
        //something went wrong
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.black26,content: Text("Something went wrong",style: TextStyle(color: Colors.white),)));
      }
    }else{
      setLoading(false);
      //something went wrong
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.black26,content: Text("Something went wrong",style: TextStyle(color: Colors.white),)));
    }
  }

  void logIntoAccount(BuildContext context,String email,String password) async{
    setLoading(true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      if(userCredential.user!=null){
        await DataService().getUserFromFirebase(context,userCredential.user!.uid);
        setLoading(false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      }else{
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.black26,content: Text("Something went wrong",style: TextStyle(color: Colors.white),)));
      }
    } on Exception catch (e) {
      // TODO
      print(e);
      setLoading(false);
    }
  }

  void GoogleAuthentication() async{
    try{
      setLoading(true);
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        User? user = userCredential.user;
        print(user);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        print(e);
      }
    }catch(e){
      print("google error $e");
      setLoading(false);
    }
  }

  void FacebookAuthentication() async{
    try{
      setLoading(true);
      FacebookAuthProvider authProvider = FacebookAuthProvider();
      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        User? user = userCredential.user;
        print(user);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        print(e);
      }
    }catch(e){
      print("facebook error $e");
      setLoading(false);
    }
  }

  void TwitterAuthentication() async{
    try{
      setLoading(true);
      TwitterAuthProvider authProvider = TwitterAuthProvider();
      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        User? user = userCredential.user;
        print(user);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        print(e);
      }
    }catch(e){
      print("facebook error $e");
      setLoading(false);
    }
  }

  void YahooAuthentication() async{
    try{
      setLoading(true);
      YahooAuthProvider authProvider = YahooAuthProvider();
      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        User? user = userCredential.user;
        print(user);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        print(e);
      }
    }catch(e){
      print("facebook error $e");
      setLoading(false);
    }
  }

  void logOutOfAccount(){

  }

}