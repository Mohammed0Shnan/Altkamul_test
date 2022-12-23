import 'package:altkamul_test/module_question/model/question_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OfflineService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'questions.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE Questions(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL , is_answered BOOLEAN NOT NULL,score INTEGER NOT NULL,view_count INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> createQuestion(QuestionModel model) async {
    final Database db = await initializeDB();
    final id = await db.insert(
        'Questions', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<QuestionModel>> getItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('Questions');
    return queryResult.map((e) => QuestionModel.fromMap(e)).toList();
  }
}



