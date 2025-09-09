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
        controller: pageController,
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
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Text(
                          listPerguntas[perguntaAtual]['enunciado'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: corRoxoMedio,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Verdadeiro',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Falso',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.screen_rotation, size: 100),
                      ],
                    ),
                  ),
                )
              : Container(),
          paginaAtual == 2
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          listPerguntas[perguntaAtual]['enunciado'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: corRoxoMedio,
                          ),
                        ),
                        Flexible(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                            itemCount: 3,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsetsGeometry.all(10),
                                child: Draggable(
                                  feedback: Material(
                                    child: Text(
                                      listPerguntas[perguntaAtual]['alternativas'][0][index],
                                    ),
                                  ),
                                  child: Text(
                                    listPerguntas[perguntaAtual]['alternativas'][0][index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Flexible(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: corRoxoMedio,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.all(10),
                                  child: Text(
                                    listPerguntas[perguntaAtual]['alternativas'][1][index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
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
