import 'package:DevQuiz/core/core.dart';
import 'package:DevQuiz/home/home_controller.dart';
import 'package:DevQuiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:DevQuiz/home/widgets/level_button/level_button_widget.dart';
import 'package:DevQuiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();

    controller.getUser();
    controller.getQuizzes();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarWidget(user: controller.user!),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 38,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelButtonWidget(label: "Fácil"),
                LevelButtonWidget(label: "Médio"),
                LevelButtonWidget(label: "Difícil"),
                LevelButtonWidget(label: "Perito"),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: controller.quizzes!.map((e) => QuizCardWidget(
                  title: e.title,
                  completed: "${e.questionAnswered} de ${e.questions.length}",
                  icon: e.image,
                  percent: e.questionAnswered / e.questions.length,
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
