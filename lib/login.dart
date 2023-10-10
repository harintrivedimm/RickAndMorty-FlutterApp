import 'package:flutter/material.dart';

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
  late TextEditingController _controller1;
  late TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _navigateHome() {
    //TODO
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const Image(image: AssetImage('assets/login_banner.png'), height: 250),
          const Padding(padding: EdgeInsets.all(16)),
          const Text("Authentication", textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 36)),
          const Text("Pickle Rick is the only one who can crack your\npassword. So don’t worry, and enter your credentials.", textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 14)),
          const Padding(padding: EdgeInsets.all(20)),
          TextField(controller: _controller1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                suffixIcon: InkWell(onTap: () { _controller1.clear(); }, child: const Icon(Icons.cancel_outlined)),
                filled: true,
                fillColor: Theme.of(context).highlightColor,
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
                suffixIcon: InkWell(onTap: () { _controller2.clear(); }, child: const Icon(Icons.cancel_outlined)),
                filled: true,
                fillColor: Theme.of(context).highlightColor,
                border: const UnderlineInputBorder(),
                hintText: 'Enter Password',
                labelText: 'Password',
                helperText: 'Your password must be at least 9 dimensions long!'
              )),
          const Padding(padding: EdgeInsets.all(16)),
          ElevatedButton(
            onPressed: _navigateHome,
            style: ElevatedButton.styleFrom(shape: const StadiumBorder(), padding: const EdgeInsets.all(16), backgroundColor: Theme.of(context).primaryColor),
            child: const Text('Authenticate', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const Padding(padding: EdgeInsets.all(16)),
          Text("Note: If no account exists, one will be created for you",
            textAlign: TextAlign.center,
            style: TextStyle(decoration: TextDecoration.none, color: Theme.of(context).primaryColor, fontSize: 12))
        ],
      ),
    );
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
