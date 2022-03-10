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
        title: const Text('Criando Transferências'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: widget._controllerCampoConta,
                rotulo: 'Numero da conta',
                dica: '0000-0'),
            Editor(
                controlador: widget._controllerCampoValor,
                rotulo: 'Valor',
                dica: 'R\$ 0000.00',
                icone: Icons.monetization_on),
            ElevatedButton(
                onPressed: () => _criarTransacao(context),
                child: const Text('Confirmar'))
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

class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  final _transferencias = <Transferencia>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
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
          final Future<Transferencia?> push =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          push.then((value) {
            setState(() {
              if (null != value) {
                _transferencias.add(value);
              }
            });
          });
        },
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
