import "package:cloud_firestore/cloud_firestore.dart";

class VocabularyList {
  late String title;
  late List<WordItem> words;
  late DateTime createdDate;
  late int clickCount;
  late List<String> hashtags;

  VocabularyList({
    required this.title,
    required this.words,
    required this.createdDate,
    required this.clickCount,
    required this.hashtags,
  });

  VocabularyList.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    title = data["title"];
    words = List<WordItem>.from(data["words"].map((item) => WordItem.fromMap(item)));
    createdDate = (data["createdDate"] as Timestamp).toDate();
    clickCount = data["clickCount"];
    hashtags = List<String>.from(data["hashtags"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "words": words.map((wordItem) => wordItem.toMap()).toList(),
      "createdDate": Timestamp.fromDate(createdDate),
      "clickCount": clickCount,
      "hashtags": hashtags,
    };
  }
}

class WordItem {
  late String word;
  late String meaning;

  WordItem({required this.word, required this.meaning});

  WordItem.fromMap(Map<String, dynamic> map) {
    word = map["word"];
    meaning = map["meaning"];
  }

  Map<String, dynamic> toMap() {
    return {
      "word": word,
      "meaning": meaning,
    };
  }
}
