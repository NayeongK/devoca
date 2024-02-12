import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:devoca/provider/model_vocabulary_provider.dart";
import "package:devoca/provider/answer_status_provider.dart";
import "package:flutter_svg/svg.dart";

class StudyScreen extends StatefulWidget {
  final int vocabularyIndex;
  const StudyScreen({Key? key, required this.vocabularyIndex}) : super(key: key);

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  bool showWord = true;
  int currentWordIndex = 0;
  Color borderColor = const Color(0xFFC6C7F7);

  @override
  Widget build(BuildContext context) {
    final answerStatusProvider = Provider.of<AnswerStatusProvider>(context);
    final vocabularyListProvider = Provider.of<VocabularyListProvider>(context);
    final vocabularyList = vocabularyListProvider.vocabularyLists[widget.vocabularyIndex];
    final wordItem = vocabularyList.words.isNotEmpty && currentWordIndex < vocabularyList.words.length
        ? vocabularyList.words[currentWordIndex]
        : null;
    final textToShow = showWord ? wordItem?.word : wordItem?.meaning;

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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("오답"),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(answerStatusProvider.incorrectCount.toString()),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("정답"),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(answerStatusProvider.correctCount.toString()),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showWord = !showWord;
                  });
                },
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    borderColor = details.delta.dx > 0 ? Colors.green : Colors.red;
                  });
                },
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (vocabularyList.words.isNotEmpty && currentWordIndex < vocabularyList.words.length) {
                    if (details.velocity.pixelsPerSecond.dx > 0) {
                      answerStatusProvider.updateWordStatus(currentWordIndex, true);
                    } else if (details.velocity.pixelsPerSecond.dx < 0) {
                      answerStatusProvider.updateWordStatus(currentWordIndex, false);
                    }
                    if (currentWordIndex < vocabularyList.words.length - 1) {
                      setState(() {
                        borderColor = const Color(0xFFC6C7F7);
                        currentWordIndex++;
                        showWord = true;
                      });
                    }
                  }
                },
                child: Container(
                  width: 280,
                  height: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(color: borderColor, width: 4),
                  ),
                  child: Text(
                    textToShow ?? "단어가 없습니다",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
