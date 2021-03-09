import 'package:flutter/material.dart';
import 'package:revenda_gas_2/models/revenda_model.dart';
import 'package:revenda_gas_2/repository/revendas_repository.dart';
import 'package:revenda_gas_2/screens/selecion_screen.dart';

class RevendaScreen extends StatefulWidget {
  @override
  _RevendaScreenState createState() => _RevendaScreenState();
}

class _RevendaScreenState extends State<RevendaScreen> {
  final List<String> filtros = [
    'Melhor Avaliação',
    'Mais Rápido',
    'Mais Barato'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Escolha uma Revenda'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.swap_vert),
              itemBuilder: (_) {
                return filtros.map((f) {
                  return PopupMenuItem(
                      child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(f),
                        Checkbox(value: false, onChanged: (bool? value) {})
                      ],
                    ),
                  ));
                }).toList();
              }),
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
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Botijões de 13Kg em:',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 8,
                      ),
                    ),
                    Text('Av Paulista,1001',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        )),
                    Text('Paulista,São Paulo, SP',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 30,
                    ),
                    Text(
                      'Mudar',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<RevendaModel>?>(
              future: RevendaRepository().buscarRevendas(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();

                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  case ConnectionState.active:

                  case ConnectionState.done:
                    var data = snapshot.data;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (_, index) {
                        return _cardRevenda(data![index]);
                      },
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _cardRevenda(RevendaModel revenda) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        SelecionScreen.routerName,
        arguments: revenda,
      ),
      child: Container(
        margin: EdgeInsets.all(15),
        //color: Colors.red,
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(
                    int.parse('FF${revenda.cor}', radix: 16),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )),
              width: 40,
              height: double.infinity,
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    revenda.tipo,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(revenda.nome),
                        Visibility(
                          visible: revenda.melhorPreco,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )),
                            child: Row(children: [
                              Icon(
                                Icons.label,
                                color: Colors.white,
                              ),
                              Text(
                                'Melhor Preço',
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nota',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${revenda.nota}',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Tempo Médio',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(text: revenda.tempoMedio),
                                    TextSpan(
                                        text: 'min',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        )),
                                  ],
                                ))
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Preço',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'R\$ ${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
