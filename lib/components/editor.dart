
import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController _controlador;
  final String _rotulo;
  final String _dica;
  final IconData? icone;

  const Editor(
      {Key? key,
        required controlador,
        required rotulo,
        required dica,
        this.icone})
      : _controlador = controlador,
        _rotulo = rotulo,
        _dica = dica,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controlador,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
            labelText: _rotulo,
            hintText: _dica,
            icon: icone != null ? Icon(icone) : null),
        keyboardType: TextInputType.number,
      ),
    );
  }
}