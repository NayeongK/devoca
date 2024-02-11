import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:devoca/provider/model_vocabulary_provider.dart";
import "package:flutter_svg/svg.dart";

class StudyScreen extends StatefulWidget {
  final int vocabularyIndex;
  const StudyScreen({Key? key, required this.vocabularyIndex}) : super(key: key);

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    final vocabularyListProvider = Provider.of<VocabularyListProvider>(context);
    final vocabularyList = vocabularyListProvider.vocabularyLists[widget.vocabularyIndex];
    final word = vocabularyList.words.isNotEmpty ? vocabularyList.words.first.word : "단어가 없습니다";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          vocabularyList.title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/back.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
            side: const BorderSide(color: Color(0xFFC6C7F7)),
          ),
          child: Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(word,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
