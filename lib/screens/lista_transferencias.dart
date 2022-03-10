import 'dart:async';

import 'package:flutter/material.dart';

import '../components/item_transferencia.dart';
import '../models/transferencia.dart';
import 'formulario_transferencia.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferenciaState extends State<ListaTransferencias> {
  final _transferencias = <Transferencia>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var transferencia = _transferencias[index];
          return ItemTransferencia(transferencia: transferencia);
        },
        itemCount: _transferencias.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then((value) => _atualiza(value));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureOr<Transferencia?> _atualiza(value) {
    setState(() {
      return null != value ? _transferencias.add(value) : null;
    });
  }
}

class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}