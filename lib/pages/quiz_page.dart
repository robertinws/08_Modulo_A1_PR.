import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo_a1_pr/global/colors.dart';
import 'package:modulo_a1_pr/global/variaveis.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController pageController = PageController();
  int paginaAtual = 0, perguntaAtual = 0;
  List<String> listIdentificadores = ['a)', 'b)', 'c)', 'd)'];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      paginaAtual == 2
          ? [DeviceOrientation.landscapeRight]
          : [DeviceOrientation.portraitUp],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Quiz My Brain'),
        foregroundColor: corRoxoMedio,
      ),
      body: PageView(
        children: [
          paginaAtual == 0
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Column(
                      spacing: 20,
                      children: [
                        Text(
                          listPerguntas[perguntaAtual]['enunciado'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: corRoxoMedio,
                          ),
                        ),
                        Column(
                          children: List.generate(4, (index) {
                            return ListTile(
                              onTap: () {},
                              title: Text(
                                '${listIdentificadores[index]} ${listPerguntas[perguntaAtual]['alternativas'][index]}',
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          paginaAtual == 1
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Column(children: []),
                  ),
                )
              : Container(),
          paginaAtual == 2
              ? SafeArea(child: Column(children: []))
              : Container(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: corRoxoMedio,
                  foregroundColor: corClara,
                ),
                child: Text('Encerrar'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: corRoxoMedio,
                  foregroundColor: corClara,
                ),
                child: Text('Próximo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
