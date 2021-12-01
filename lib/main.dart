import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var log = Logger();
  bool selected = false;
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interesting Animations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: true,
        colors: const [
          Colors.green,
          Colors.white,
          Colors.pink,
          Colors.orange,
          Colors.blue
        ],
        createParticlePath: drawStar,

      ),

          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Center(
              child: FlipCard(
                direction: FlipDirection.VERTICAL,
                  speed: 1500,
                  front: Container(
                      width: 350,
                      height: 350,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'images/fp250.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  back: Container(
                      width: 350,
                      height: 350,
                      color: Colors.blueGrey,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "'Flower of Imagination'",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              " -by Michael May",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )))),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(32.0),
            child: Text('\$500.00',
            style: TextStyle(
              fontSize: 20,
            ),),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: selected ? 250.0 : 200.0,
                height: selected ? 80.0 : 30.0,
                curve: Curves.elasticInOut,
                child: MaterialButton(
                  onPressed: () {
                    _controllerCenter.play();

                    setState(() {
                      selected = !selected;
                    });
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('Tap here to purchase'),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}
