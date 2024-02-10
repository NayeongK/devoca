import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:devoca/model_vocabulary.dart";

enum IsSuccessLoad { ready, process, success }

class VocabularyListProvider with ChangeNotifier {
  late CollectionReference vocabularyListReference;
  IsSuccessLoad isSuccessLoad = IsSuccessLoad.ready;
  List<VocabularyList> vocabularyLists = [];

  late Stream<QuerySnapshot> snapshot;

  VocabularyListProvider({reference}) {
    vocabularyListReference =
        reference ?? FirebaseFirestore.instance.collection("vocabularyLists");
  }

  fetchItems() async {
    if (isSuccessLoad != IsSuccessLoad.success) {
      isSuccessLoad = IsSuccessLoad.process;
      vocabularyLists = await vocabularyListReference.get().then((QuerySnapshot results) {
        return results.docs.map((DocumentSnapshot document) {
          var result = VocabularyList.fromSnapshot(document);
          if (kDebugMode) {
            print("fetchItem: $result");
          }
          return result;
        }).toList();
      });
      isSuccessLoad = IsSuccessLoad.success;
      notifyListeners();
    }
  }

  void getSnapshot() {
    snapshot = vocabularyListReference.snapshots();
    snapshot.listen((qs) {
      for (DocumentChange dc in qs.docChanges) {
        VocabularyList result = VocabularyList.fromSnapshot(dc.doc);
        switch (dc.type) {
          case DocumentChangeType.added:
            vocabularyLists.insert(0, result);
            break;
          case DocumentChangeType.modified:
            int index = vocabularyLists.indexWhere((vl) => vl.title == result.title);
            if (index != -1) {
              vocabularyLists[index] = result;
            }
            break;
          case DocumentChangeType.removed:
            vocabularyLists.removeWhere((vl) => vl.title == result.title);
            break;
        }
      }
      notifyListeners();
    });
  }
}
