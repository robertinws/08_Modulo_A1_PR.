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
  int paginaAtual = 0, perguntaAtual = 0, alternativaSelecionada = -1;
  List<String> listIdentificadores = ['a)', 'b)', 'c)', 'd)'];
  bool confirmar = false;
  int score = 0;
  String tipo = '';
  double rotacao = 0.1;
  bool animando = false, entradaFeita = false, entradaVF = false;

  @override
  void initState() {
    super.initState();
    contexto = context;
  }

  void encerrar() async {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: corEscuro,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(
                'Score:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: corClara,
                ),
              ),
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: corClara,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void proximo() async {
    if (confirmar) {
      confirmar = false;
      alternativaSelecionada = -1;
      perguntaAtual++;
      if (tipo != listPerguntas[perguntaAtual]['tipo']) {
        paginaAtual++;
        await pageController.animateToPage(
          paginaAtual,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        if (paginaAtual == 1 && !entradaFeita) {
          entradaFeita = true;
          entradaAnimacao();
        }
      }
      setState(() {});
    } else {
      confirmar = true;
      listPerguntas[perguntaAtual]['resposta'] ==
              alternativaSelecionada
          ? score =
                score +
                int.parse(
                  listPerguntas[perguntaAtual]['peso'].toString(),
                )
          : null;
      setState(() {});
    }
  }

  void entradaAnimacao() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        entradaVF = true;
        animando = true;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        rotacao = 0.2;
        alternativaSelecionada = 1;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        rotacao = 0.1;
        alternativaSelecionada = 0;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        entradaVF = false;
        alternativaSelecionada = -1;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        animando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      paginaAtual == 2
          ? [DeviceOrientation.landscapeRight]
          : [DeviceOrientation.portraitUp],
    );
    tipo = listPerguntas[perguntaAtual]['tipo'];
    return Scaffold(
      backgroundColor: corClara,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Quiz My Brain'),
        foregroundColor: corRoxoMedio,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
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
                              tileColor:
                                  confirmar &&
                                      listPerguntas[perguntaAtual]['resposta'] ==
                                          index &&
                                      confirmar
                                  ? corRoxoMedio
                                  : corClara,
                              textColor:
                                  listPerguntas[perguntaAtual]['resposta'] ==
                                          index &&
                                      confirmar
                                  ? corClara
                                  : alternativaSelecionada == index
                                  ? corRoxoMedio
                                  : corEscuro,
                              onTap: confirmar
                                  ? null
                                  : () {
                                      setState(() {
                                        alternativaSelecionada =
                                            index;
                                      });
                                    },
                              title: Text(
                                '${listIdentificadores[index]} ${listPerguntas[perguntaAtual]['alternativas'][index]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
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
                              onTap: animando
                                  ? null
                                  : () {
                                      setState(() {
                                        alternativaSelecionada = 0;
                                      });
                                    },
                              child: Text(
                                'Verdadeiro',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: alternativaSelecionada == 0
                                      ? corRoxoMedio
                                      : corEscuro,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: animando
                                  ? null
                                  : () {
                                      setState(() {
                                        alternativaSelecionada = 1;
                                      });
                                    },
                              child: Text(
                                'Falso',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: alternativaSelecionada == 1
                                      ? corRoxoMedio
                                      : corEscuro,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedOpacity(
                          opacity: entradaVF ? 1 : 0,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          child: AnimatedRotation(
                            turns: rotacao,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                            child: Icon(
                              Icons.screen_rotation,
                              size: 100,
                            ),
                          ),
                        ),
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
                onPressed: animando ? null : encerrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: corRoxoMedio,
                  foregroundColor: corClara,
                ),
                child: Text('Encerrar'),
              ),
              ElevatedButton(
                onPressed: animando
                    ? null
                    : paginaAtual == 2
                    ? proximo
                    : alternativaSelecionada == -1
                    ? null
                    : proximo,
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
