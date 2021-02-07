import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'helper/classifier.dart';
import 'helper/lookup.dart';
import 'dart:math';
import 'category.dart';

class Recognizer extends StatefulWidget {
  @override
  _RecognizerState createState() => _RecognizerState();
}

class _RecognizerState extends State<Recognizer> {
  // ------------------------- List to match ---------------------//
  List<String> check = [
    'angry',
    'depressed',
    'pressure',
    'strain',
    'tension',
    'fear',
    'bother',
    'trouble',
    'worry',
    'sad',
    'agonize',
    'despair',
    'lonely',
    'heartbroken',
    'gloomy',
    'disappointed',
    'hopeless',
    'grieved',
    'unhappy',
    'troubled',
    'miserable',
    'nervous',
    'horrified',
    'stressed',
    'frustrated',
    'annoyed',
    'irritated',
    'mad',
    'vengeful',
    'insulted'
  ];

  //--------------random -------------------//
  Random random = Random();

  int val1=0, val2=0; double value = 0.0;

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button to start speaking';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  //-------------------------- PopUp 1 --------------------------------//
  _launchURL() async {
    int rand = random.nextInt(11);
    String url = urlLook(rand);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not Launch: $url";
    }
  }

  Widget button(String image, String tap) {
    return GestureDetector(
      onTap: () {
        if (tap == 'videos') {
          Vibration.cancel();
          _launchURL();
        }
        if (tap == "category") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Category()));
        }
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.contain)),
      ),
    );
  }

  reaction() {
    int rand = random.nextInt(5);
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.blue),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(lookUp(rand)), fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RawMaterialButton(
              fillColor: Theme.of(context).primaryColor,
              onPressed: () {
                Vibration.cancel();
              },
              elevation: 10.0,
              child: Icon(
                Icons.vibration,
                size: 40.0,
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              button('images/cute.gif', 'category'),
              button('images/laugh.gif', 'videos'),
            ],
          ),
          MaterialButton(
              minWidth: 30.0,
              height: 20.0,
              onPressed: () {
                Navigator.pop(context);
              },
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //---------------------- Model ---------------------------//
  Classifier _classifier = Classifier();

  //------------------------------ Speech to Text Convert ---------------------------//

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('OnStatus: $val'),
        onError: (val) => print('onStatus: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (_speech.lastStatus == 'notListening') {
              print(_classifier.classify(_text));

              if (check.any((e) => _text.contains(e))) {val1 = 1;}
              else{ val1 = 0;}
              val2 = _classifier.classify(_text);
              value = val1*0.66 + val2*0.33;

              if (value>0.5) {
                setState(() => _isListening = false);
                _speech.stop();
                Vibration.vibrate(pattern: [
                  500,
                  2000,
                  500,
                  2000,
                  500,
                  2000,
                  500,
                  2000,
                  500,
                  2000,
                  500,
                  2000,
                  500,
                  2000,
                  500,
                  2000,
                ]);
                reaction();
              }
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

//------------------------------------- main portion ---------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Stress Reliever',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).accentColor,
            endRadius: 100.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
                onPressed: () {
                  Vibration.cancel();
                  _listen();
                },
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 30.0,
                )),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 300,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                      child: Text(
                        _text,
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
