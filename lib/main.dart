import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme.copyWith(
            primaryColor: Colors.green[900],
            colorScheme:
                theme.colorScheme.copyWith(secondary: Colors.blueAccent[700]),
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blueAccent[700],
                textTheme: ButtonTextTheme.primary)),
        home: ListaTransferencias());
  }
}



