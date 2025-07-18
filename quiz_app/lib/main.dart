import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:quiz_app/splash_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(MyApp());
}

class Question {
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}

final List<Question> questionList = [
  Question(
    question: 'Capital of France?',
    options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
    answerIndex: 2,
  ),
  Question(
    question: '2 + 2 = ?',
    options: ['3', '4', '5', '6'],
    answerIndex: 1,
  ),
  Question(
    question: 'Fastest land animal?',
    options: ['Cheetah', 'Tiger', 'Horse', 'Lion'],
    answerIndex: 0,
  ),
  Question(
    question: 'H2O is?',
    options: ['Oxygen', 'Water', 'Helium', 'Hydrogen'],
    answerIndex: 1,
  ),
  Question(
    question: 'Android is by?',
    options: ['Apple', 'Microsoft', 'Google', 'Intel'],
    answerIndex: 2,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizyy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/quiz': (context) => QuizScreen(),
        '/result': (context) => ResultScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,

        centerTitle: true,
        title: const Text(
          'Home',

          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(decoration: BoxDecoration(color: Colors.black)).box
                .width(context.screenWidth)
                .height(context.screenHeight)
                .make(),

            Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ).withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'RULES AND REGULATIONS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ).box.padding(const EdgeInsets.all(10)).make(),
                      const Text(
                        '1. Each question has 4 options.\n'
                        '2. You have 10 seconds to answer each question.\n'
                        '3. Correct answer gives you 1 point.\n'
                        '4. No negative marking for wrong answers.\n'
                        '5. Quiz ends after all questions are answered.\n'
                        '6. Your score will be displayed at the end.\n'
                        '7. Have fun and good luck!',
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ).box.padding(const EdgeInsets.all(10)).make(),
                    ],
                  ),
                  height: 360,
                ).box.alignTopCenter
                .width(context.screenWidth - 50)
                .height(context.screenHeight - 100)
                .make(),

            50.heightBox,

            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(100.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: const TextStyle(fontSize: 24),
                  minimumSize: Size(300, 60),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },

                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    wordSpacing: 2,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  int score = 0;
  int timer = 10;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    // Start timer when the widget is initialized.
    startTimer();
  }

  /// Starts or resets the 10-second timer.
  void startTimer() {
    setState(() {
      timer = 10;
    });
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timer > 0) {
          timer--;
        } else {
          // Auto-skip question when timer reaches zero.
          t.cancel();
          nextQuestion();
        }
      });
    });
  }

  /// Processes the answer and moves to the next question.
  void nextQuestion([int? selectedIndex]) {
    // Check answer only if the user tapped an option.
    if (selectedIndex != null &&
        selectedIndex == questionList[questionIndex].answerIndex) {
      score++;
    }

    // Advance to the next question or navigate to result.
    if (questionIndex < questionList.length - 1) {
      setState(() {
        questionIndex++;
      });
      // Restart the timer for the next question.
      startTimer();
    } else {
      countdownTimer?.cancel();
      // Navigate to the Result screen with the final score.
      Navigator.pushReplacementNamed(context, '/result', arguments: score);
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questionList[questionIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(color: const Color.fromARGB(255, 0, 0, 0)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              50.heightBox,
              Container(
                child: Text(
                  'Question ${questionIndex + 1} of ${questionList.length}',
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),

              SizedBox(height: 16),
              20.heightBox,
              Container(
                child: Text(
                  currentQuestion.question,
                  style: const TextStyle(fontSize: 45, color: Colors.white),
                ),
              ),

              const SizedBox(height: 24),
              50.heightBox,
              // Render the answer options.
              ...List.generate(currentQuestion.options.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      countdownTimer?.cancel();
                      nextQuestion(index);
                    },

                    child: Text(
                      currentQuestion.options[index],
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ).box.width(context.screenWidth - 100).make(),
                );
              }),
              const Spacer(),
              Container(
                color: Colors.orange,
                child: Text(
                  'Time left: $timer seconds',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ).box.width(context.screenWidth).make(),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int score = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 0, 0, 0),
          ).box.width(context.screenWidth).height(context.screenHeight).make(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                    height: 360,

                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ).withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Quiz Completed!',
                          style: TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Your score: $score / ${questionList.length}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            // Navigate back to home.
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          child: const Text(
                            'Back to Home',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).box.width(context.screenWidth - 80).make(),
                      ],
                    ),
                  ).box
                  .width(context.screenWidth - 20)
                  .height(context.screenHeight - 500)
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}
