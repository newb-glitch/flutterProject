import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SamApp extends StatefulWidget {
  const SamApp({super.key});

  @override
  State<SamApp> createState() => _SamAppState();
}

class _SamAppState extends State<SamApp> {
  final FlutterTts flutterTts = FlutterTts();
  final SpeechToText stt = SpeechToText();
  bool recording = false;
  String wrds = '';
  late TextEditingController controller;
  String text = '';
  double pch = 0.0;
  double vol = 0.0;
  double srt = 0.0;
  String ans = '';
  String url = '';
  var data;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    initSpeech();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  speak(String txt) async {
    await flutterTts.setLanguage("fil-PH");
    await flutterTts.setPitch(0);
    await flutterTts.setVolume(vol);
    await flutterTts.speak(txt);
  }

  void initSpeech() async {
    recording = await stt.initialize();
    setState(() {});
  }

  void goListen() async {
    await stt.listen(onResult: recResult);
  }

  void stopListen() async {
    await stt.stop();
    setState(() {
      controller.text += wrds;
    });
  }

  fetchdata(String qdata) async {
    http.Response response = await http.get(Uri.parse(qdata));
    return response;
  }

  void recResult(SpeechRecognitionResult result) {
    setState(() {
      wrds = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sample Text-to-Speech'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Center(
              child: Column(
            children: [
              TextField(
                controller: controller,
                onChanged: (value) => {
                  setState(() {
                    text = controller.text;
                  })
                },
                onSubmitted: (String value) {
                  setState(() {
                    text = controller.text;
                    flutterTts.speak(text);
                  });
                },
              ),
              TextField(
                onChanged: (value) {
                  url =
                      'http://127.0.0.1:5000/api?query=60 ${value.toString()}';
                },
              ),
              TextButton(
                  onPressed: () async {
                    data = await fetchdata(url);
                    var dec = jsonDecode(data);
                    setState(() {
                      ans = dec['output'];
                    });
                  },
                  child: const Text("asci")),
              Text(wrds),
              Text(ans),
              ElevatedButton(
                  onPressed: () =>
                      {stt.isNotListening ? goListen() : stopListen()},
                  child: const Icon(Icons.play_circle)),
              ElevatedButton(
                  onPressed: () {
                    wrds = " ";
                    controller.text = " ";
                  },
                  child: const Icon(Icons.delete)),
              const Text('Speed'),
              Slider(
                  value: srt,
                  onChanged: (ns) {
                    setState(() {
                      srt = ns;
                      flutterTts.setSpeechRate(srt);
                    });
                  }),
              ElevatedButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: const Icon(Icons.arrow_back))
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            text = controller.text,
            flutterTts.speak('did you say: $text ?')
          },
          child: const Icon(Icons.play_arrow),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Challenges'),
                onTap: () {},
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back), label: 'Back'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        ),
      ),
    );
  }
}
