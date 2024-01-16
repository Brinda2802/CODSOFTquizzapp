import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'Is the sky blue?',
      'type': 'true_false',
      'correctAnswer': true,
    },
    {
      'question': 'What is 45*98?',
      'type': 'mcq',
      'options': ['1101', '4411', '310', '4410'],
      'correctAnswer': '4410',
    },
    // Add more questions similarly
  ];

  int questionIndex = 0;

  void answerQuestion(dynamic answer) {
    bool isCorrect = false;
    if (questions[questionIndex]['type'] == 'mcq') {
      isCorrect = questions[questionIndex]['correctAnswer'] == answer;
    } else if (questions[questionIndex]['type'] == 'true_false') {
      isCorrect = questions[questionIndex]['correctAnswer'] == answer;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Correct!' : 'Incorrect!',
        ),
        duration: Duration(seconds: 1),
      ),
    );

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      setState(() {
        questionIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              questions[questionIndex]['question'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            if (questions[questionIndex]['type'] == 'mcq')
              Column(
                children: (questions[questionIndex]['options'] as List<String>).map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        answerQuestion(option);
                      },
                      child: Text(option),
                    ),
                  );
                }).toList(),
              ),
            if (questions[questionIndex]['type'] == 'true_false')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      answerQuestion(true);
                    },
                    child: Text('True'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      answerQuestion(false);
                    },
                    child: Text('False'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
