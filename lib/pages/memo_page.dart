import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modulo_a1_pr/global/colors.dart';
import 'package:modulo_a1_pr/global/variaveis.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  List<dynamic> listCards = [];
  List<String> listImages1 = [
        'arara.jpg',
        'macacoprego.jpg',
        'onca.jpg',
        'tamandua.jpg',
      ],
      listImages2 = ['car1.jpg', 'car2.jpg', 'car3.jpg', 'car4.jpg'];
  int tema = 0;
  String start = 'START';

  @override
  void initState() {
    super.initState();
    contexto = context;
    iniciar();
  }

  void iniciar() async {
    listarCards();
  }

  void selecionarImagem() async {
    List<dynamic> list = await methodChannel.invokeMethod('imagens');
    if (list.isNotEmpty) {
      if (listImages3.isNotEmpty) {
        listImages3.clear();
      }
      for (var img in list) {
        listImages3.add(base64Decode(img));
      }
      listarCards();
      Fluttertoast.showToast(msg: 'Imagens selecionadas');
      setState(() {});
    }
  }

  void listarCards() async {
    if (listCards.isNotEmpty) {
      listCards.clear();
    }
    int tipo = 0;
    for (int i = 0; i < 8; i++) {
      int qntRepetida = 0;
      for (var card in listCards) {
        card['tipo'] == tipo ? qntRepetida++ : null;
      }
      if (qntRepetida >= 2) {
        tipo++;
      }
      listCards.add({
        'tipo': tipo,
        'visivel': true,
        'acertado': false,
        'random': Random().nextInt((listCards.length + 1) * 100),
        'imagem': tema == 0
            ? listImages1[tipo]
            : tema == 1
            ? listImages2[tipo]
            : listImages3[tipo],
      });
    }
    embaralhar();
    setState(() {});
  }

  void embaralhar() async {
    listCards.sort(
      (a, b) =>
          a['random'].toString().compareTo(b['random'].toString()),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: corRoxoMedio,
        title: Text(
          'MemoCheck',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          Column(
            spacing: 10,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tempo: ',
                            style: TextStyle(
                              color: corRoxoMedio,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: corRoxoMedio,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '00:00',
                              style: TextStyle(
                                color: corRoxoMedio,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Text(
                            'Acertos: ',
                            style: TextStyle(
                              color: corRoxoMedio,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: corRoxoMedio,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '00',
                              style: TextStyle(
                                color: corRoxoMedio,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Text(
                            'Erros: ',
                            style: TextStyle(
                              color: corRoxoMedio,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: corRoxoMedio,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '00',
                              style: TextStyle(
                                color: corRoxoMedio,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: GridView.builder(
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2.4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listCards.length,
                  itemBuilder: (context, index) {
                    final card = listCards[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: corRoxoMedio,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: card['visivel']
                              ? tema == 2
                                    ? Image.memory(
                                        (card['imagem']),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/${card['imagem']}',
                                        fit: BoxFit.cover,
                                      )
                              : Container(color: corRoxoClaro),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: corRoxoMedio,
                foregroundColor: corClara,
              ),
              child: Text('START'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Text('Tema: '),
                  DropdownButton(
                    value: tema,
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Text('Animais da Amazonia'),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Carros'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Minhas Imagens'),
                      ),
                    ],
                    onChanged: (newValue) {
                      newValue as int == 2
                          ? listImages3.isEmpty
                                ? Fluttertoast.showToast(
                                    msg:
                                        'Selecione 4 imagens na galeria',
                                  )
                                : setState(() {
                                    tema = 2;
                                    listarCards();
                                  })
                          : setState(() {
                              tema = newValue;
                              listarCards();
                            });
                    },
                  ),
                ],
              ),
              IconButton(
                onPressed: selecionarImagem,
                icon: Icon(
                  Icons.settings,
                  color: corRoxoMedio,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
