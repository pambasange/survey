import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:survey/person_page.dart';
import 'package:flutter/services.dart';


class dass extends StatefulWidget {
  const dass({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<dass> {
  List nomes = [];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getSampleTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return
                    SurveyKit(
                  //  onResult: (SurveyResult result) {
                      onResult: (SurveyResult result) {
                        for (var stepResult in result.results) {
                          for (var questionResult in stepResult.results) {
                            nomes.add(questionResult);
                            print(nomes);
                            // Here are your question results

                          }
                          if (result.finishReason == FinishReason.COMPLETED) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => home()));
                            // navigate to new page
                            return;
                          }
                        }
                      },
                    task: task,
                    showProgress: true,

                    themeData: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      ).copyWith(
                        onPrimary: Colors.white,
                      ),
                      primaryColor: Colors.cyan,
                      backgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.cyan,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.cyan,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.cyan,
                        selectionColor: Colors.cyan,
                        selectionHandleColor: Colors.cyan,
                      ),
                      cupertinoOverrideTheme: CupertinoThemeData(
                        primaryColor: Colors.cyan,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(150.0, 40.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return BorderSide(
                                  color: Colors.grey,
                                );
                              }
                              return BorderSide(
                                color: Colors.cyan,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                  color: Colors.grey,
                                );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                color: Colors.cyan,
                              );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                       style: ButtonStyle(
                         textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.cyan,
                            ),
                          ),
                       ),
                      ),
                      textTheme: TextTheme(
                        headline2: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        headline5: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        bodyText2: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        subtitle1: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.blueAccent,
                    ),
                    );
                }
                return CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Seremos breve\nRápidas questões\nSobre o teu dia anterior',
          text: 'Tão logo sinta-se pronto, avance!',
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          title: 'Cansado',
          stepIdentifier: StepIdentifier(id: '1'),
          text: 'Se sentiu cansado sem nenhuma razão aparente?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Nervoso',
          stepIdentifier: StepIdentifier(id: '2'),
          text: 'Se sentiu nervoso?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Acalmar',
          stepIdentifier: StepIdentifier(id: '3'),
          text: 'Se sentiu nervoso ao ponto de nada o conseguir acalmar?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Agitado',
          stepIdentifier: StepIdentifier(id: '4'),
          text: 'Se sentiu irrequieto ou agitado?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Irrequieto',
          stepIdentifier: StepIdentifier(id: '5'),
          text: 'Se sentiu irrequieto ao ponto de não conseguir parar quieto?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Deprimido',
          stepIdentifier: StepIdentifier(id: '6'),
          text: 'Se sentiu deprimido?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Esforço',
          stepIdentifier: StepIdentifier(id: '7'),
          text: 'Se sentiu que tudo era um esforço?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Esperança',
          stepIdentifier: StepIdentifier(id: '8'),
          text: 'se sentiu sem esperança?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Animar',
          stepIdentifier: StepIdentifier(id: '9'),
          text: 'se sentiu tão triste que nada o conseguiu animar?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Inútil',
          stepIdentifier: StepIdentifier(id: '10'),
          text: 'se sentiu inútil?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Nenhum dia', value: '1'),
              TextChoice(text: 'Poucos dias', value: '2'),
              TextChoice(text: 'Alguns dias', value: '3'),
              TextChoice(text: 'A maior parte dos dias', value: '4'),
              TextChoice(text: 'Todos os dias', value: '5'),
            ],
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '11'),
          showAppBar: false,
          text: 'Obrigado pelo o seu tempo',
          title:  'Concluido',
          buttonText: 'Terminar',
        ),
      ],
    );
    return Future.value(task);
  }

}