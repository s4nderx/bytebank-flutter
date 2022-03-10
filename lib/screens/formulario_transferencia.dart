import 'package:flutter/material.dart';

import '../components/editor.dart';
import '../models/transferencia.dart';

const _tituloAppBar = 'Criando Transferências';
const _rotuloBtnNumeroConta = 'Numero da conta';
const _dicaBtnNumeroConta = '0000-0';
const _rotuloBtnValor = 'Valor';
const _dicaBtnValor = 'R\$ 0000.00';
const _textButton = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controllerCampoConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: widget._controllerCampoConta,
                rotulo: _rotuloBtnNumeroConta,
                dica: _dicaBtnNumeroConta),
            Editor(
                controlador: widget._controllerCampoValor,
                rotulo: _rotuloBtnValor,
                dica: _dicaBtnValor,
                icone: Icons.monetization_on),
            ElevatedButton(
                onPressed: () => _criarTransacao(context),
                child: const Text(_textButton))
          ],
        ),
      ),
    );
  }

  void _criarTransacao(BuildContext context) {
    final int? numeroConta = int.tryParse(widget._controllerCampoConta.text);
    final double? valor = double.tryParse(widget._controllerCampoValor.text);
    if (numeroConta != null && valor != null) {
      final Transferencia transferenciaCriada =
      Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}