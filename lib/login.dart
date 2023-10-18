import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const LoginPage(title: "Login"),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showContent = false;
  late TextEditingController _controller1;
  late TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => {
      debugPrint("Firebase Initialized"),
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          debugPrint("User logged in: ${user.email}");
          setState(() {
            showContent = false;
          });
          _navigateHome();
        } else {
          setState(() {
            showContent = true;
          });
        }
      }).onError((error) {
        debugPrint("Get User Error: $error");
        setState(() {
          showContent = true;
        });
      })
    }).onError((error, stackTrace) => {
      debugPrint("Firebase Initialization Error: $error"),
      setState(() {
        showContent = true;
      })
    });

    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _login() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _controller1.text,
      password: _controller2.text)
      .then((userCredential) => {
        debugPrint("Signin Success..."),
        _navigateHome()
      }).onError((error, stackTrace) => {
        debugPrint("Signin Error..."),
        if(error is FirebaseAuthException){
          debugPrint(error.code),
          if (error.code == 'INVALID_LOGIN_CREDENTIALS') {
            debugPrint('Wrong password.'),
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Wrong login credential")))
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${error.message}")))
          }
        }
      });
  }

  void _register() {
     FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _controller1.text,
      password: _controller2.text).then((user) => {
         debugPrint("Signup Success...")
      }).onError((error, stackTrace) => {
        debugPrint("Signup Error..."),
         if(error is FirebaseAuthException){
           debugPrint(error.code),
           if (error.code == 'email-already-in-use') {
             debugPrint('Email already in use.'),
             _login()
           } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${error.message}")))
           }
         }
      });
  }

  void _navigateHome() {
    //TODO
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: content(),
    );
  }

  Widget content() {
    if(showContent) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const Image(
              image: AssetImage('assets/login_banner.png'), height: 250),
          const Padding(padding: EdgeInsets.all(16)),
          const Text("Authentication", textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 36)),
          const Text(
              "Pickle Rick is the only one who can crack your\npassword. So don’t worry, and enter your credentials.",
              textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 14)),
          const Padding(padding: EdgeInsets.all(20)),
          TextField(controller: _controller1,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  suffixIcon: InkWell(onTap: () {
                    _controller1.clear();
                  }, child: const Icon(Icons.cancel_outlined)),
                  filled: true,
                  fillColor: Theme
                      .of(context)
                      .highlightColor,
                  border: const UnderlineInputBorder(),
                  hintText: 'Enter your E-mail',
                  labelText: 'E-mail',
                  helperText: 'It\'s the key to your portal gun!'
              )),
          const Padding(padding: EdgeInsets.all(8)),
          TextField(controller: _controller2,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.edit_outlined),
                suffixIcon: InkWell(onTap: () {
                  _controller2.clear();
                }, child: const Icon(Icons.cancel_outlined)),
                filled: true,
                fillColor: Theme
                    .of(context)
                    .highlightColor,
                border: const UnderlineInputBorder(),
                hintText: 'Enter Password',
                labelText: 'Password',
                helperText: 'Your password must be at least 9 dimensions long!',
              )),
          const Padding(padding: EdgeInsets.all(16)),
          ElevatedButton(
            onPressed: () {
              if (_controller1.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email is empty")));
              } else if (_controller2.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password is empty")));
              } else {
                _register();
              }
            },
            style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Theme
                    .of(context)
                    .primaryColor),
            child: const Text('Authenticate',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const Padding(padding: EdgeInsets.all(16)),
          Text("Note: If no account exists, one will be created for you",
              textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.none, color: Theme
                  .of(context)
                  .primaryColor, fontSize: 12))
        ],
      );
    } else {
      return const Center();
    }
  }
}

// onSubmitted: (String value) async {
// await showDialog<void>(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// title: const Text('Thanks!'),
// content: Text(
// 'You typed "$value", which has length ${value.characters.length}.'),
// actions: <Widget>[
// TextButton(
// onPressed: () {
// Navigator.pop(context);
// },
// child: const Text('OK')),
// ]);
// });
// },
