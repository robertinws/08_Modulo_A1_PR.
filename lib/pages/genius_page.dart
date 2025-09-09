import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo_a1_pr/global/colors.dart';

class GeniusPage extends StatefulWidget {
  const GeniusPage({super.key});

  @override
  State<GeniusPage> createState() => _GeniusPageState();
}

class _GeniusPageState extends State<GeniusPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: corRoxoMedio,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Genius Play',
              style: TextStyle(
                color: corRoxoMedio,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 100,
              child: DropdownButton(
                value: 0,
                items: List.generate(3, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text('Português'),
                  );
                }),
                onChanged: (newValue) {},
              ),
            ),
          ],
        ),
        actions: [],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'Score: ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: corRoxoMedio,
                    ),
                  ),
                  Text(
                    '0000',
                    style: TextStyle(
                      fontSize: 17,
                      color: corRoxoMedio,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: corRoxoMedio,
                  foregroundColor: corClara,
                ),
                child: Text('Restart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
