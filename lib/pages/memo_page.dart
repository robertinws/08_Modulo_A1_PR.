import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo_a1_pr/global/colors.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
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
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: corRoxoClaro,
                            border: Border.all(
                              width: 1,
                              color: corRoxoMedio,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                    value: 0,
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Text('Animais da Amazonia'),
                      ),
                    ],
                    onChanged: (newValue) {},
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
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
