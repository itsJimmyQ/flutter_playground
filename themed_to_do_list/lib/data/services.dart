import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:themed_to_do_list/data/models.dart';

const String COLLECTION_TO_DO = 'toDo';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  late final _refCollection;

  DatabaseService() {
    _refCollection = _db.collection(COLLECTION_TO_DO).withConverter<ToDo>(
          fromFirestore: (snapshots, _) => ToDo.fromJson(snapshots.data()!),
          toFirestore: (toDo, _) => toDo.toJson(),
        );
  }

  Stream<QuerySnapshot> getToDos() {
    return _refCollection.snapshots();
  }

  void addToDo(ToDo toDo) async {
    await _refCollection.add(toDo);
  }
}
