import 'package:flutter/material.dart';
import 'myquiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizzy = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> keepScore = [];

  void checkAns(bool userPicked) {
    bool correctAns = quizzy.getAns();

    setState(() {
      if (quizzy.isFinished() == true) {

        Alert(
          context: context,
          title: 'Finished!',
            desc: 'You\'ve reached the end of the Quiz',
        ).show();

        quizzy.reset();
        keepScore = [];

      } else {
        if (correctAns == userPicked) {
          keepScore.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          keepScore.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }

        quizzy.getNextQuest();
      }
    });
  }

  /* // old method using lists to store the questions and answers

  List<String> questNum = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];

  List<bool> answers = [
    false,
    true,
    true,
  ];
   */
  /* sample of creating an object based of the class in the other .dart file
  Question myStore = Question(
    q: 'You can lead a cow down stairs but not up stairs.',
    a: false,
  );
   */

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzy.getQuestiontext(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAns(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAns(false);
              },
            ),
          ),
        ),
        Row(
          children: keepScore,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
