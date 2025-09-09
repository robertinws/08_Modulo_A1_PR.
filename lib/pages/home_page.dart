import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo_a1_pr/global/colors.dart';
import 'package:modulo_a1_pr/global/variaveis.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    contexto = context;
    iniciar();
  }

  void iniciar() async {
    listPerguntas = jsonDecode(
      await rootBundle.loadString('assets/jsons/bancoQuestoes.json'),
    )['perguntas'];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!valueConexao.value && !popInternet) {
        popInternet = true;
        await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text(
                'Sem conexão com internet, seus dados podem não estar completamente salvos.',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corRoxoMedio,
                    foregroundColor: corClara,
                  ),
                  child: Text('Fechar'),
                ),
              ],
            );
          },
        );
      }
      if (await battery.isInBatterySaveMode && !popEconomia) {
        popEconomia = true;
        await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text(
                'Seu dispositivo está no modo economia de energia, alguns recursos podem ser limitados.',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corRoxoMedio,
                    foregroundColor: corClara,
                  ),
                  child: Text('Fechar'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Column(
          spacing: 10,
          children: [
            DrawerHeader(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: corRoxoMedio,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/pessoa4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: corRoxoMedio,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: corRoxoMedio,
                      ),
                      Divider(color: corRoxoMedio),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed('/quiz');
                        },
                        title: Text(
                          'QuizMyBrain',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: corRoxoMedio,
                      ),
                      Divider(color: corRoxoMedio),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'GeniusPLay',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: corRoxoMedio,
                      ),
                      Divider(color: corRoxoMedio),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'MemoCheck',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: corRoxoMedio,
                      ),
                      Divider(color: corRoxoMedio),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        title: Text(
                          'Sair',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: corRoxoMedio,
                      ),
                      Divider(color: corRoxoMedio),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            Image.asset(
              height: 100,
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
            Text(
              'Bem-vindo ao Aprender+',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
