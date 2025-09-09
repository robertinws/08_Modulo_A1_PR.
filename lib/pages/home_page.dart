import 'package:flutter/material.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
