import 'package:flutter/material.dart';

class Flip extends StatelessWidget {
  const Flip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FlipPage(),
    );
  }

}

class FlipPage extends StatefulWidget {
  const FlipPage({Key? key}) : super(key: key);


  @override
  _FlipPageState createState() => _FlipPageState();
}

class _FlipPageState extends State<FlipPage> {

  //Variables and functions


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar Tile here'),
      ),
    );
  }
}