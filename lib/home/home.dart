import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage(title: "Home");
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Select Character"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a settings')));
          },
        ),
      ]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_outlined),
            label: 'Favourites',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return CharacterItem(index: index, title: entries[index]);
            }
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
      ][currentPageIndex],
    );
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    super.key,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        height: 180,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black26, Colors.grey, Colors.white],
            begin: Alignment.bottomCenter, end: Alignment.center),
        ),
        child: Stack(children: [
          const Image(image: AssetImage('assets/list_item.png'), height: 180, alignment: Alignment.center),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Name: $title', style: const TextStyle(color: Colors.black, fontSize: 20)),
                    Text('Other: $title', style: const TextStyle(color: Colors.black, fontSize: 20))
                  ],
                ),
              // ElevatedButton(
              //     onPressed: () {
              //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Card $index'), duration: const Duration(seconds: 2)));
              //     },
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.all(6),
              //       shape: const StadiumBorder(),
              //       backgroundColor: Theme.of(context).primaryColor
              //     ),
              //   child: const Icon(Icons.arrow_forward, color: Colors.black),
              // ),
            ]),
          )
        ]),
      ),
    );
  }
}



