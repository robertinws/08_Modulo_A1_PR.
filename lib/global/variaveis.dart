import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String caminhoCanal = 'com.example.modulo_a1_pr';
Battery battery = Battery();
bool popBateria = false;
BuildContext? contexto;
EventChannel eventInternet = EventChannel('$caminhoCanal/internet');
ValueNotifier<bool> valueConexao = ValueNotifier(false);
