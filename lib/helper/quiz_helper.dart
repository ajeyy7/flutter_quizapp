import 'package:flutter_quizapp/helper/sample_questions.dart';
import 'package:flutter_quizapp/model/quiz_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

// Global Variable
String tableName = 'QuizTable';
String id = 'id';
String question = 'question';
String option1 = 'option1';
String option2 = 'option2';
String option3 = 'option3';
String option4 = 'option4';
String correctAnswer = 'correctAnswer';

class QuizHelper {
  QuizHelper._();

  static QuizHelper? quizHelper;

  factory QuizHelper() {
    if (quizHelper == null) {
      quizHelper = QuizHelper._();
    }
    return quizHelper!;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await createDb();
    }
    return _database!;
  }






  // Create Database here
  Future<Database> createDb() async {
    var openDb;
    try {
      String createTable = '''
      create table $tableName (
        $id integer primary key autoincrement,
        $question text,
        $option1 text,
        $option2 text,
        $option3 text,
        $option4 text,
        $correctAnswer integer
      )
      ''';

      String appDir = await getDatabasesPath();
      String openPath = p.join(appDir, 'QuizDatabase.db');

      // Open Database file
      openDb = await openDatabase(openPath, version: 1,
          onCreate: (Database db, int version) {
        // Create table here
        db.execute(createTable);
        print('Table Created $openDb');
      });
    } catch (e) {
      print('Table Creation error: ${e.toString()}');
    }
    return openDb;
  }

  // Insert a record into the database
  Future<bool> insertRecord(QuizModel quizModel) async {
    try {
      Database db = await database;
      var count = await db.insert(tableName, quizModel.toMap());
      print('Data Inserted: $count');
      return true;
    } catch (e) {
      print('Data insert error: ${e.toString()}');
      return false;
    }
  }

  // Fetch records from the database
  Future<List<QuizModel>> fetchRecord() async {
    List<QuizModel> list = [];
    try {
      Database db = await database;
      final List<Map<String, dynamic>> listMap = await db.query(tableName);
      print(
          'Number of records fetched: ${listMap.length}'); // Check the number of records

      if (listMap.isNotEmpty) {
        listMap.forEach((Map<String, dynamic> action) {
          QuizModel quizModel = QuizModel.fromMap(action);
          list.add(quizModel);
        });
      }
      return list;
    } catch (e) {
      print('Fetching data error: ${e.toString()}');
      return list;
    }
  }

  // Insert simple sample questions into the database
  Future<void> insertSimpleQuestion() async {
    List<QuizModel> sampleQuestions = getQuestions();
    for (var questions in sampleQuestions) {
      await insertRecord(questions);
    }
  }

  // Clear all records from the database
  Future<void> clearDatabase() async {
    Database db = await database;
    await db.delete(tableName); // Clear existing data
    print('Database cleared');
  }

  // Delete the database file (useful if you want to reset the app completely)
  Future<void> deleteDatabaseFile() async {
    String appDir = await getDatabasesPath();
    String dbPath = p.join(appDir, 'QuizDatabase.db');
    await deleteDatabase(dbPath); // Delete the database file
    print('Database file deleted');
  }
}
