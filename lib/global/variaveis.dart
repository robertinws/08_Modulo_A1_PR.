import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String caminhoCanal = 'com.example.modulo_a1_pr';
Battery battery = Battery();
bool popBateria = false, popInternet = false, popEconomia = false;
BuildContext? contexto;
EventChannel eventInternet = EventChannel('$caminhoCanal/internet'),
    eventFones = EventChannel('$caminhoCanal/fones'),
    eventSensor = EventChannel('$caminhoCanal/sensor');
ValueNotifier<bool> valueConexao = ValueNotifier(false);
List<dynamic> listPerguntas = [];
