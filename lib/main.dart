import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _controllerCampoValor,
              style: TextStyle(fontSize: 16),
              decoration:
                  InputDecoration(labelText: 'Valor', hintText: 'R\$ 0000.00'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _controllerCampoNumeroConta,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                  labelText: 'Numero da conta',
                  hintText: '0000-0',
                  icon: Icon(Icons.monetization_on)),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final int? numeroConta =
                    int.tryParse(_controllerCampoNumeroConta.text);
                final double? valor =
                    double.tryParse(_controllerCampoValor.text);
                if (numeroConta != null && valor != null) {
                  final Transferencia transferenciaCriada =
                      Transferencia(valor, numeroConta);
                  debugPrint('$transferenciaCriada');
                }
              },
              child: const Text('Confirmar'))
        ],
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(transferencia: Transferencia(1000.0, 999)),
          ItemTransferencia(transferencia: Transferencia(1000.1, 991)),
          ItemTransferencia(transferencia: Transferencia(1000.2, 992)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia({Key? key, required transferencia})
      : _transferencia = transferencia,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
