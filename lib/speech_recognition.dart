import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

const languages = const [
  const Language('Pусский', 'ru_RU'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class SpeechRecognitionPage extends StatefulWidget {
  @override
  _SpeechRecognitionPageState createState() => _SpeechRecognitionPageState();
}

class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Тест',
            style: TextStyle(
              fontSize: 18
            ),),
          actions: [
            PopupMenuButton<Language>(
              onSelected: _selectLangHandler,
              itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey.shade200,
                          child: Text(transcription,
                          style: TextStyle(
                            fontSize: 18
                          ),))),
                  _buildButton(
                    onPressed: _speechRecognitionAvailable && !_isListening
                        ? () => start()
                        : null,
                    label: _isListening
                        ? 'Слушаю...'
                        : 'Слушать (${selectedLang.code})',
                  ),
                  _buildButton(
                    onPressed: _isListening ? () => cancel() : null,
                    label: 'Отменить',
                  ),
                  _buildButton(
                    onPressed: _isListening ? () => stop() : null,
                    label: 'Остановить',
                  ),
                ],
              ),
            )),
      ),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => CheckedPopupMenuItem<Language>(
    value: l,
    checked: selectedLang == l,
    child: Text(
        l.name,
      style: TextStyle(
        fontSize: 18
      ),
    ),
  ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => Padding(
      padding: EdgeInsets.all(12.0),
      child: RaisedButton(
        color: Colors.cyan.shade600,
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white,
            fontSize: 18
          ),
        ),
      ));

  void start() => _speech
      .listen(locale: selectedLang.code)
      .then((result) => print('_MyAppState.start => result $result'));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
            () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => setState(() => transcription = text);

  void onRecognitionComplete() => setState(() => _isListening = false);
}