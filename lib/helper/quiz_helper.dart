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

  // Create database and table for user data
  Future<Database> creatusereDb() async {
    var openDb;
    try {
      String createTable = '''
        create table User (
        id integer primary key autoincrement,
        username text
      )
      ''';

      String appDir = await getDatabasesPath();
      String openPath = p.join(appDir, 'UserDatabase.db');
      openDb = await openDatabase(openPath, version: 1, onCreate: (Database db, int version) {
        db.execute(createTable);
        print('Table Created $openDb');
      });
    } catch (e) {
      print('Table Creation error: ${e.toString()}');
    }
    return openDb;
  }

  // Insert username
  Future<bool> insertUsername(String username) async {
    try {
      Database db = await database;
      var count = await db.insert('User', {'username': username});
      print('Username Inserted: $count');
      return true;
    } catch (e) {
      print('Error inserting username: ${e.toString()}');
      return false;
    }
  }

  // Fetch username
  Future<String?> fetchUsername() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query('User');
      if (result.isNotEmpty) {
        return result.first['username'] as String;
      }
      return null;
    } catch (e) {
      print('Error fetching username: ${e.toString()}');
      return null;
    }
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
    await insertRecord(QuizModel(
      question: 'What is the capital of France?',
      option1: 'Berlin',
      option2: 'Madrid',
      option3: 'Paris',
      option4: 'Lisbon',
      correctAnswer: 3,
    ));

    // Add more sample questions...
    await insertRecord(QuizModel(
      question: 'Who wrote "Romeo and Juliet"?',
      option1: 'William Shakespeare',
      option2: 'Charles Dickens',
      option3: 'J.K. Rowling',
      option4: 'Mark Twain',
      correctAnswer: 1,
    ));
    await insertRecord(QuizModel(
      question: 'What is the capital of France?',
      option1: 'Berlin',
      option2: 'Madrid',
      option3: 'Paris',
      option4: 'Lisbon',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Who wrote "Romeo and Juliet"?',
      option1: 'William Shakespeare',
      option2: 'Charles Dickens',
      option3: 'J.K. Rowling',
      option4: 'Mark Twain',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'What is the largest planet in our solar system?',
      option1: 'Earth',
      option2: 'Jupiter',
      option3: 'Mars',
      option4: 'Saturn',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What year did World War I begin?',
      option1: '1914',
      option2: '1939',
      option3: '1918',
      option4: '1923',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'What element does "O" represent on the periodic table?',
      option1: 'Oxygen',
      option2: 'Osmium',
      option3: 'Gold',
      option4: 'Oganesson',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Who painted the Mona Lisa?',
      option1: 'Vincent van Gogh',
      option2: 'Leonardo da Vinci',
      option3: 'Pablo Picasso',
      option4: 'Claude Monet',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What is the capital of Japan?',
      option1: 'Beijing',
      option2: 'Seoul',
      option3: 'Tokyo',
      option4: 'Bangkok',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which planet is known as the Red Planet?',
      option1: 'Earth',
      option2: 'Mars',
      option3: 'Venus',
      option4: 'Mercury',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'In which year did the Titanic sink?',
      option1: '1912',
      option2: '1905',
      option3: '1920',
      option4: '1915',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Who developed the theory of relativity?',
      option1: 'Isaac Newton',
      option2: 'Albert Einstein',
      option3: 'Galileo Galilei',
      option4: 'Nikola Tesla',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What is the capital of Canada?',
      option1: 'Toronto',
      option2: 'Vancouver',
      option3: 'Ottawa',
      option4: 'Montreal',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which is the largest island in the world?',
      option1: 'Greenland',
      option2: 'New Guinea',
      option3: 'Borneo',
      option4: 'Madagascar',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'In what year did the United States declare independence?',
      option1: '1776',
      option2: '1492',
      option3: '1812',
      option4: '1607',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which famous scientist developed the theory of evolution?',
      option1: 'Isaac Newton',
      option2: 'Charles Darwin',
      option3: 'Galileo Galilei',
      option4: 'Albert Einstein',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What is the currency of Japan?',
      option1: 'Yuan',
      option2: 'Won',
      option3: 'Yen',
      option4: 'Ringgit',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question:
          'Who was the first female Prime Minister of the United Kingdom?',
      option1: 'Margaret Thatcher',
      option2: 'Theresa May',
      option3: 'Angela Merkel',
      option4: 'Indira Gandhi',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which planet is known as the Morning Star?',
      option1: 'Venus',
      option2: 'Mars',
      option3: 'Saturn',
      option4: 'Jupiter',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'What year did World War II end?',
      option1: '1945',
      option2: '1939',
      option3: '1950',
      option4: '1940',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which country is known as the Land of the Rising Sun?',
      option1: 'China',
      option2: 'South Korea',
      option3: 'Japan',
      option4: 'India',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which ocean is the largest?',
      option1: 'Atlantic Ocean',
      option2: 'Indian Ocean',
      option3: 'Arctic Ocean',
      option4: 'Pacific Ocean',
      correctAnswer: 4,
    ));

    await insertRecord(QuizModel(
      question: 'Who invented the light bulb?',
      option1: 'Alexander Graham Bell',
      option2: 'Nikola Tesla',
      option3: 'Thomas Edison',
      option4: 'Benjamin Franklin',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'What is the currency of the United Kingdom?',
      option1: 'Euro',
      option2: 'Pound Sterling',
      option3: 'Yen',
      option4: 'Dollar',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'Which country is known for the Eiffel Tower?',
      option1: 'United States',
      option2: 'France',
      option3: 'Italy',
      option4: 'Spain',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What is the largest city in the United States by population?',
      option1: 'Los Angeles',
      option2: 'Chicago',
      option3: 'New York City',
      option4: 'Houston',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which is the tallest building in the world?',
      option1: 'Empire State Building',
      option2: 'Eiffel Tower',
      option3: 'Burj Khalifa',
      option4: 'Shanghai Tower',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which element has the atomic number 1?',
      option1: 'Oxygen',
      option2: 'Carbon',
      option3: 'Hydrogen',
      option4: 'Nitrogen',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which country is known as the "Land Down Under"?',
      option1: 'Australia',
      option2: 'New Zealand',
      option3: 'South Africa',
      option4: 'Argentina',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Who was the first president of the United States?',
      option1: 'Abraham Lincoln',
      option2: 'George Washington',
      option3: 'Thomas Jefferson',
      option4: 'John Adams',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'In which country is the Great Barrier Reef located?',
      option1: 'New Zealand',
      option2: 'Australia',
      option3: 'United Kingdom',
      option4: 'United States',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'Which continent is known as the "Dark Continent"?',
      option1: 'Asia',
      option2: 'Africa',
      option3: 'Europe',
      option4: 'South America',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'Which of these countries does NOT have a coastline?',
      option1: 'Switzerland',
      option2: 'Norway',
      option3: 'France',
      option4: 'Italy',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which animal is the largest mammal on Earth?',
      option1: 'African Elephant',
      option2: 'Blue Whale',
      option3: 'Giraffe',
      option4: 'Great White Shark',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'Who invented the airplane?',
      option1: 'Leonardo da Vinci',
      option2: 'Wright Brothers',
      option3: 'Thomas Edison',
      option4: 'Albert Einstein',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'In which year did the Berlin Wall fall?',
      option1: '1989',
      option2: '1991',
      option3: '1987',
      option4: '1990',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which country is famous for its pyramids?',
      option1: 'Egypt',
      option2: 'Mexico',
      option3: 'India',
      option4: 'Italy',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'What is the capital of Italy?',
      option1: 'Venice',
      option2: 'Rome',
      option3: 'Florence',
      option4: 'Milan',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'Which is the longest river in the world?',
      option1: 'Amazon River',
      option2: 'Nile River',
      option3: 'Yangtze River',
      option4: 'Mississippi River',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What is the official language of Brazil?',
      option1: 'Spanish',
      option2: 'Portuguese',
      option3: 'English',
      option4: 'French',
      correctAnswer: 2,
    ));

    await insertRecord(QuizModel(
      question: 'What is the chemical symbol for silver?',
      option1: 'Ag',
      option2: 'Au',
      option3: 'Si',
      option4: 'Pb',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which country is home to the ancient city of Petra?',
      option1: 'Jordan',
      option2: 'Egypt',
      option3: 'Greece',
      option4: 'Turkey',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Which is the smallest country in the world?',
      option1: 'Vatican City',
      option2: 'Monaco',
      option3: 'San Marino',
      option4: 'Liechtenstein',
      correctAnswer: 1,
    ));

    await insertRecord(QuizModel(
      question: 'Who painted the "Starry Night"?',
      option1: 'Pablo Picasso',
      option2: 'Claude Monet',
      option3: 'Vincent van Gogh',
      option4: 'Leonardo da Vinci',
      correctAnswer: 3,
    ));


  await insertRecord(QuizModel(
    question: 'What is the most common gas in the Earth\'s atmosphere?',
    option1: 'Oxygen',
    option2: 'Carbon Dioxide',
    option3: 'Nitrogen',
    option4: 'Argon',
    correctAnswer: 3,
  ));

  await insertRecord(QuizModel(
    question: 'Which animal is known for its ability to mimic sounds?',
    option1: 'Parrot',
    option2: 'Dolphin',
    option3: 'Monkey',
    option4: 'Elephant',
    correctAnswer: 1,
  ));

  await insertRecord(QuizModel(
    question: 'Which country is known for the famous Eiffel Tower?',
    option1: 'Italy',
    option2: 'United States',
    option3: 'France',
    option4: 'England',
    correctAnswer: 3,
  ));

  await insertRecord(QuizModel(
    question: 'Which country invented pizza?',
    option1: 'Italy',
    option2: 'Greece',
    option3: 'United States',
    option4: 'France',
    correctAnswer: 1,
  ));

    await insertRecord(QuizModel(
      question: 'Which country is known for the famous Eiffel Tower?',
      option1: 'Italy',
      option2: 'United States',
      option3: 'France',
      option4: 'England',
      correctAnswer: 3,
    ));

    await insertRecord(QuizModel(
      question: 'Which country invented pizza?',
      option1: 'Italy',
      option2: 'Greece',
      option3: 'United States',
      option4: 'France',
      correctAnswer: 1,
    ));
    // Add more sample questions here as needed
    print('Sample questions inserted');
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
