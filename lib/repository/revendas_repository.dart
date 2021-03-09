import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:revenda_gas_2/models/revenda_model.dart';

class RevendaRepository {
  Future<List<RevendaModel>?> buscarRevendas() async {
    var jsonFileDados = await rootBundle.loadString('data/dados.json');
    var revendas = json.decode(jsonFileDados) as List;

    return revendas.map((r) => RevendaModel.fromMap(r)).toList();
  }
}
