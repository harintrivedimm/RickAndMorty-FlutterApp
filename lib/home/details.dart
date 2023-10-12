import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailPage(title: "Details");
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.title});

  final String title;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey,
                  child: const Image(image:  AssetImage('assets/list_item.png'), fit: BoxFit.fitHeight),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back, color: Colors.black)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(Icons.star, color: Colors.black)),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(6),
                child: Text("Title", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 34))),
            Padding(padding: const EdgeInsets.all(12), child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                    children: [
                      SizedBox(height: 50, child: Text("Label 1: ", style: TextStyle(color: Theme.of(context).primaryColor))),
                      const SizedBox(height: 50, child: Text("Value 1", style: TextStyle(color: Colors.black))),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(height: 50, child: Text("Label 2: ", style: TextStyle(color: Theme.of(context).primaryColor))),
                      const SizedBox(height: 50, child: Text("Value 2", style: TextStyle(color: Colors.black))),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(height: 50, child: Text("Label 3: ", style: TextStyle(color: Theme.of(context).primaryColor))),
                      const SizedBox(height: 50, child: Text("Value 3", style: TextStyle(color: Colors.black))),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(height: 50, child: Text("Label 4: ", style: TextStyle(color: Theme.of(context).primaryColor))),
                      const SizedBox(height: 50, child: Text("Value 4", style: TextStyle(color: Colors.black))),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(height: 50, child: Text("Label 5: ", style: TextStyle(color: Theme.of(context).primaryColor))),
                      const SizedBox(height: 50, child: Text("Value 5", style: TextStyle(color: Colors.black))),
                    ]
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
