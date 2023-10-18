import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty/login.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return const OnboardingPage(title: "Onboarding");
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.title});

  final String title;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final PageController controller = PageController();

  bool showContent = false;
  final int total = 3;
  int page = 1;

  @override
  void initState() {
    super.initState();
    getVisited().then((value) => {
      if(value) {
        setState(() {
          showContent = false;
        }),
        _navigateMain()
      } else {
        setState(() {
          showContent = true;
        }),
      }
    });
  }

  Future<bool> getVisited() async {
    return await _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('isVisited') ?? false;
    });
  }

  setVisited() async {
    await _prefs.then((SharedPreferences prefs) {
      prefs.setBool('isVisited', true);
    });
  }

  void _nextPage() {
    page++;
    if(page <= total) {
      controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
    else if(page > total)
    {
      _navigateMain();
    }
  }

  void _navigateMain() {
    setVisited();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child : content());
  }

  Widget content() {
    if(showContent) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/banner.png'), height: 100),
          Expanded(
            flex: 1,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: const <Widget>[
                Banner(image: "assets/image_1.png",
                    title: "Get Schwifty",
                    description: "Get ready to have some \nfun with Rick and Morty"),
                Banner(image: "assets/image_2.png",
                    title: "Wubba Lubba Dub Dub",
                    description: "Welcome to the Rick \nand Morty universe"),
                Banner(image: "assets/image_3.png",
                    title: "To Infinity and Beyond",
                    description: "Explore the multiverse \nwith Rick and Morty"),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        _navigateMain();
                      },
                      child: const Text("Skip", style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 20))
                  ),
                  FloatingActionButton(
                    onPressed: _nextPage,
                    tooltip: 'Next',
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              )
          )
        ]);
    } else {
      return const Center();
    }
  }

}

class Banner extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const Banner({
    super.key, required this.image, required this.title, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(image), alignment: Alignment.center, fit: BoxFit.fitHeight),
          const Padding(padding: EdgeInsets.all(10)),
          Text(title, textAlign: TextAlign.center,
              style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontStyle: FontStyle.normal, fontSize: 30)),
          const Padding(padding: EdgeInsets.all(10)),
          Text(description, textAlign: TextAlign.center,
              style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontStyle: FontStyle.normal, fontSize: 18)),
        ]
    );
  }
}
