import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AuthApp());
}

class AuthApp extends StatefulWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth with Firebase (Logged ' +
              (user == null ? 'out' : 'in') +
              ')'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: emailControler,
              ),
              TextField(
                controller: passwordControler,
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailControler.text,
                                password: passwordControler.text);
                        setState(() {});
                      },
                      child: Text('Регистрация')),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailControler.text,
                            password: passwordControler.text);
                        setState(() {});
                      },
                      child: Text('Войти')),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {});
                      },
                      child: Text('Выйти'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
