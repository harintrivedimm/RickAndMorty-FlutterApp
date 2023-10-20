import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty/Networking/data.dart';
import 'package:rick_and_morty/Networking/rest_client.dart';

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
  final logger = Logger();

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
        indicatorColor: const Color(0xFFE8DEF8),
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
          child: buildListView(context),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
      ][currentPageIndex],
    );
  }

  FutureBuilder<Result> buildListView(BuildContext context) {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<Result>(
      future: client.getCharacters().catchError((obj) {
        switch (obj.runtimeType) {
          case DioException e:
            final res = e.response;
            logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res?.statusMessage ?? '')));
            return const Result();
          default:
            return const Result();
        }
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final Result? response = snapshot.data;
          final List<Character>? list = response?.results;
          return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: list?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return CharacterItem(index: index, obj: list![index]);
              }
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    super.key,
    required this.index,
    required this.obj,
  });

  final int index;
  final Character obj;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 6,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
          Stack(
            alignment: Alignment.center,
            children: [
            Image.network(obj.image ?? '', height: 160, fit: BoxFit.fill),
            Container(
              height: 160,
              decoration: const BoxDecoration(gradient: LinearGradient(
                colors: [Colors.black45, Colors.transparent, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.center))),
          ]),
          Container(
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${obj.name}',
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.left),
                      Text('Species: ${obj.species}',
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.left)
                    ],
                  )
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Card $index'), duration: const Duration(seconds: 2)));
                  },
                  style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xFFE8DEF8)),
                  child: const Icon(Icons.arrow_forward, color: Colors.black),
                )]
            )),
          ],
        ),
      ),
    );
  }
}



