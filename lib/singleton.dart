import 'package:flutter/cupertino.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'navigate.dart';
import 'package:provider/provider.dart';
import 'package:stinger_tracker/main.dart';

const languages = const [
  const Language('Pусский', 'ru_RU'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class Singleton extends ChangeNotifier {
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  int selectedIndexHome = 0;
  int selectedIndexDetails = 0;

  bool isNavigating = false;
  bool isPop = false;
  bool isNavigatingToCamera = false;

  String transcription = '';

  String last = "";

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  bool Mykhalich = false;

  void activateSpeechRecognizer(BuildContext context) {
    print('_MyAppState.activateSpeechRecognizer... ');
    this._speech = new SpeechRecognition();
    this._speech.setAvailabilityHandler(onSpeechAvailability);
    this._speech.setCurrentLocaleHandler(onCurrentLocale);
    this._speech.setRecognitionStartedHandler(onRecognitionStarted);
    this._speech.setRecognitionResultHandler(onRecognitionResult);
    //this._speech.setRecognitionCompleteHandler(onRecognitionComplete);
    this._speech
        .activate()
        .then((res) => this._speechRecognitionAvailable = res);
    notifyListeners();
  }

  void start() {
    this._speech
        .listen(locale: selectedLang.code)
        .then((result) => print('_MyAppState.start => result ${result}'));
    notifyListeners();
  }

  void cancel() {
    this._speech.cancel().then((result) => _isListening = result);
    notifyListeners();
  }

  void stop() {
    this._speech.stop().then((result) => _isListening = result);
    notifyListeners();
  }

  void onSpeechAvailability(bool result) {
    this._speechRecognitionAvailable = result;
    notifyListeners();
  }

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    this.selectedLang = languages.firstWhere((l) => l.code == locale);
    notifyListeners();
  }

  void onRecognitionStarted() {
    this._isListening = true;
    notifyListeners();
  }

  void onRecognitionResult(String text) {
    this.transcription = text;
    String lastLast = this.last;
    if (lastLast != transcription.split(" ").last) {
      this.last = transcription.split(" ").last;
      print("transcription: $last");
      if (last == "Михалыч" || last == "михалыч") {
        this.Mykhalich = true;
        this.transcription = "";
        notifyListeners();
      }
      if (Mykhalich) {
        if (last == "Уходи" || last == "уходи") {
          this.Mykhalich = false;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Назад" || last == "назад") {
          this.isPop = true;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Задачи" || last == "задачи") {
          this.selectedIndexHome = 0;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Избранное" || last == "избранное") {
          this.selectedIndexHome = 1;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "История" || last == "история") {
          this.selectedIndexHome = 2;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Настройки" || last == "настройки") {
          this.selectedIndexHome = 3;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Форма" || last == "форма") {
          this.isNavigating = true;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Описание" || last == "описание") {
          this.selectedIndexDetails = 0;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Заявки" || last == "заявки") {
          this.selectedIndexDetails = 1;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Дефекты" || last == "дефекты") {
          this.selectedIndexDetails = 2;
          this.transcription = "";
          notifyListeners();
        }
        if (last == "Камера" || last == "камера") {
          this.isNavigatingToCamera = true;
          this.transcription = "";
          notifyListeners();
        }
      }
      notifyListeners();
    }
  }
}