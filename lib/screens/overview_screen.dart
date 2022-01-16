import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromRGBO(253, 111, 150, 1),
                fontSize: 38,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText("Chuck"),
                  WavyAnimatedText('Norris'),
                  WavyAnimatedText('Jokes'),
                ],
                isRepeatingAnimation: true,
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130), //ADJUST THIS VALUE
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              height: 57.0,
              child: Material(
                color: const Color.fromRGBO(254, 242, 243, 1),
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                      child: Text('Log out')
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
