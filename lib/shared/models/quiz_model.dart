import 'dart:convert';

import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:collection/collection.dart';

enum Level {
  facil,
  medio,
  dificil,
  perito,
}

extension LevelStringExt on String {
  Level get parse => {
    "facil": Level.facil,
    "medio": Level.medio,
    "dificil": Level.dificil,
    "perito": Level.perito,
  }[this]!;
}

extension LevelExt on Level {
  String get parse => {
    Level.facil: "facil",
    Level.medio: "medio",
    Level.dificil: "dificil",
    Level.perito: "perito",
  }[this]!;
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final int questionAnswered;
  final String image;
  final Level level;

  QuizModel({
    required this.title,
    required this.questions,
    this.questionAnswered = 0,
    required this.image,
    required this.level,
  });

  QuizModel copyWith({
    String? title,
    List<QuestionModel>? questions,
    int? questionAnswered,
    String? image,
    Level? level,
  }) {
    return QuizModel(
      title: title ?? this.title,
      questions: questions ?? this.questions,
      questionAnswered: questionAnswered ?? this.questionAnswered,
      image: image ?? this.image,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'questionAnswered': questionAnswered,
      'image': image,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      questions: List<QuestionModel>.from(map['questions']?.map((x) => QuestionModel.fromMap(x))),
      questionAnswered: map['questionAnswered'],
      image: map['image'],
      level: map['level'].toString().parse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuizModel(title: $title, questions: $questions, questionAnswered: $questionAnswered, image: $image, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is QuizModel &&
      other.title == title &&
      listEquals(other.questions, questions) &&
      other.questionAnswered == questionAnswered &&
      other.image == image &&
      other.level == level;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      questions.hashCode ^
      questionAnswered.hashCode ^
      image.hashCode ^
      level.hashCode;
  }
}
