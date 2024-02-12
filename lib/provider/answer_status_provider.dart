import "package:flutter/foundation.dart";

class AnswerStatusProvider with ChangeNotifier {
  final Map<int, bool> _wordStatuses = {};

  void updateWordStatus(int wordIndex, bool isCorrect) {
    _wordStatuses[wordIndex] = isCorrect;
    notifyListeners();
  }

  void resetSession() {
    _wordStatuses.clear();
    notifyListeners();
  }

  int get correctCount =>
      _wordStatuses.values.where((isCorrect) => isCorrect).length;

  int get incorrectCount =>
      _wordStatuses.values.where((isCorrect) => !isCorrect).length;
}
