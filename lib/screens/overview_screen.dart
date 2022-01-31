import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<GetJokes> fetchPrayerTime() async {
  final response =
      await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

  if (response.statusCode == 200) {
    return GetJokes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load jokes');
  }
}

class GetJokes {
  final String jokes;

  const GetJokes({
    this.jokes = " ",
  });

  factory GetJokes.fromJson(Map<String, dynamic> json) {
    return GetJokes(
      jokes: json['value'],
    );
  }
}

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  Future<GetJokes> futureJokes;

  @override
  void initState() {
    super.initState();
    futureJokes = fetchPrayerTime();
  }

  void _getNewJokes() {
    setState(() {
      futureJokes = fetchPrayerTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 15),
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
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                FutureBuilder<GetJokes>(
                    future: futureJokes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              snapshot.data.jokes,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return CircularProgressIndicator();
                      }
                      return CircularProgressIndicator();
                    })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90), //ADJUST THIS VALUE
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              height: 57.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromRGBO(111, 105, 172, 1),
                child: ElevatedButton(
                  onPressed: _getNewJokes,
                  child: const Center(
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                        child: Text('Load New Jokes')),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10), //ADJUST THIS VALUE
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
                        child: Text('Log Out')),
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
