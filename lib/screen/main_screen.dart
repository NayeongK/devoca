import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:devoca/provider/model_vocabulary_provider.dart";
import "package:devoca/provider/answer_status_provider.dart";
import "package:devoca/screen/study_screen.dart";

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MainList());
  }
}

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    final vocabularyProvider = Provider.of<VocabularyListProvider>(context);
    final answerStatusProvider = Provider.of<AnswerStatusProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: vocabularyProvider.vocabularyLists.length,
                itemBuilder: (context, index) {
                  final vocabularyList = vocabularyProvider.vocabularyLists[index];
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        answerStatusProvider.resetSession();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                              StudyScreen(
                                vocabularyIndex: index,
                              )));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vocabularyList.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800]
                              ),
                            ),
                            const SizedBox(height: 13),
                            Wrap(
                              spacing: 8.0,
                              children: vocabularyList.hashtags.map((tag) => Chip(
                                label: Text("# ${tag}",
                                  style: const TextStyle(fontSize: 12)
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              )).toList(),
                            ),
                            const SizedBox(height: 45)
                          ],
                        ),
                      )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
