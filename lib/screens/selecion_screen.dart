import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:revenda_gas_2/components/mainButton.dart';
import 'package:revenda_gas_2/components/stageButton.dart';
import 'package:revenda_gas_2/models/revenda_model.dart';

class SelecionScreen extends StatefulWidget {
  static String routerName = '/selecion';
  final RevendaModel revenda;
  const SelecionScreen({
    Key? key,
    required this.revenda,
  }) : super(key: key);

  @override
  _SelecionScreenState createState() => _SelecionScreenState(revenda: revenda);
}

class _SelecionScreenState extends State<SelecionScreen> {
  final RevendaModel revenda;
  double valorTotal;

  _SelecionScreenState({required this.revenda}) : valorTotal = revenda.preco;

  var appBar = AppBar(
    title: Text('Selecionar Produto'),
    actions: [
      PopupMenuButton(
          icon: Icon(Icons.help_outline),
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                child: Text('Suporte'),
              ),
              PopupMenuItem(
                child: Text('Termos de Serviço'),
              ),
            ];
          })
    ],
  );

  var qntprod = 0;
  void add() {
    setState(() {
      qntprod++;
      valorTotal = revenda.preco * qntprod;
    });
  }

  void remove() {
    if (qntprod > 0) {
      setState(() {
        qntprod--;
        valorTotal = revenda.preco * qntprod;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: Column(
        children: [
          _buildStage(),
          _buildSubTitle(),
          _buildContent(),
          Spacer(),
          Mainbutton()
        ],
      ),
    );
  }

  Container _buildStage() {
    return Container(
      padding: EdgeInsets.all(34),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      //height: 144,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Stagebutton(
            label: 'Comprar',
            staged: true,
          ),
          Expanded(
            child: Column(
              children: [
                Divider(
                  height: 1,
                  // thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          const Stagebutton(
            label: 'Pagamento',
            staged: false,
          ),
          Expanded(
            child: Column(
              children: [
                Divider(
                  height: 1,
                  // thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          const Stagebutton(
            label: 'Confirmação',
            staged: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(21),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 34,
            width: 34,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse('FF${revenda.cor}', radix: 16))),
            child: Center(
              child: Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
            ),
          ),
          Text(revenda.nome),
          Text('Botijão de 13kg'),
          Spacer(),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'R\$',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${valorTotal.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      //eight: 150,
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.home,
                  size: 55,
                  color: Colors.grey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      revenda.nome,
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Text(
                          revenda.nota.toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
                Text('${revenda.tempoMedio} min'),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 34,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      revenda.tipo,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(21.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Botijao de 13kg'),
                    Text(revenda.nome),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'R\$',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          remove();
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          '$qntprod',
                          style: TextStyle(fontSize: 21),
                        )),
                      ),
                      IconButton(
                        onPressed: () {
                          add();
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
