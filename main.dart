import 'dart:io';

class Node {
  Node? prox = null;
  int valor = 0;
  Node? anterior = null;
  Node() {}
  void set_valor(var valor) {
    this.valor = valor;
  }

  int get_valor() {
    return this.valor;
  }

  Node? proximo() {
    return prox;
  }

  void set_proximo(Node? no) {
    prox = no;
  }

  Node? get_anterior() {
    return anterior;
  }

  void set_anterior(Node? no) {
    anterior = no;
  }
}

//Criação nó na lista:
void criar_no(Node? no) {
  if (no?.prox == null) {
    Node novoNo = Node();
    no?.set_proximo(novoNo);
    novoNo.set_anterior(no);
  } else {
    criar_no(no?.proximo());
  }
}

void forma_lista(Node? no, var entrada, bool resultado_lista) {
  double tamanho = (entrada.length - 1) / 3;
  if (resultado_lista) {
    tamanho = tamanho + 2;
  }
  for (int t = 0; t < tamanho.floor(); t++) {
    criar_no(no);
  }
}

void set_valor(Node? no, var entrada) {
  double valor = double.parse("${entrada}");
  if (no?.prox != null) {
    no?.set_valor(valor.floor() % 1000);
    valor = valor / 1000;
    set_valor(no?.proximo(), valor);
  } else {
    no?.set_valor(valor.floor() % 1000);
  }
}

//Inicio da multiplicação:
void multiplicacao(Node? lista1, Node? lista2, Node? resultado) {
  int sobra = 0;
  multiplica(lista1?.get_valor(), lista2, resultado, sobra);
  if (lista1?.prox != null) {
    multiplicacao(lista1?.proximo(), lista2, resultado);
  } else {}
}

//Multiplicação:
void multiplica(var valor_lista1, Node? lista2, Node? result, int sobra) {
  int? resp;

  result?.valor = result.valor + sobra;
  sobra = 0;
  if (result!.valor > 999) {
    sobra = sobra + (result.valor / 1000).floor();
  }

  resp = valor_lista1 * lista2!.get_valor();
  if (resp != null) {
    if (resp > 999) {
      result.set_valor(resp.floor() % 1000);
      sobra = sobra + (resp / 1000).floor();
      if (lista2.prox != null) {
        multiplica(valor_lista1, lista2.proximo(), result.proximo(), sobra);
      } else {
        result.prox!.valor = result.prox!.valor + sobra;
        sobra = 0;
      }
    } else {
      result.set_valor(resp.floor() % 1000);
      if (lista2.prox != null) {
        multiplica(valor_lista1, lista2.proximo(), result.proximo(), sobra);
      } else {
        result.prox!.valor = result.prox!.valor + sobra;
        sobra = 0;
      }
    }
  }
}

//Função de saída:
void saida(Node? resultado) {
  String? saida = "Resultado: ";
  var lista_output = [];
  String temp = "";
  pegarValores(resultado, lista_output);
  for (int t = lista_output.length - 1; t >= 0; t--) {
    if (lista_output[t] == "0") {
      temp = temp + "000";
    } else if (lista_output[t].length < 3) {
      temp = temp + "0" + lista_output[t];
    } else if (lista_output[t].length < 2) {
      temp = temp + "00" + lista_output[t];
    } else {
      temp = temp + lista_output[t];
    }
  }
  saida = saida + temp;
  print(saida);
}

void pegarValores(Node? result, var listaOut) {
  listaOut.add(result?.valor.toString());
  if (result?.prox != null) {
    pegarValores(result?.prox, listaOut);
  } else {
    print(result?.valor);
  }
}

void main() {
  Node lista1 = Node();
  Node lista2 = Node();
  Node resultado = Node();

  print("Digite o primeiro valor para multiplicação: ");
  final input = stdin.readLineSync();
  forma_lista(lista1, input, false);
  set_valor(lista1, input);
  var tam1 = input!.length;

  print("Digite o sergundo valor para multiplicação: ");
  final segundo_input = stdin.readLineSync();
  forma_lista(lista2, segundo_input, false);
  set_valor(lista2, segundo_input);
  var tam2 = segundo_input!.length;
  print("----------------");

  if (tam1 > tam2) {
    forma_lista(resultado, input, true);
  } else if (tam1 < tam2) {
    forma_lista(resultado, segundo_input, true);
  } else {
    forma_lista(resultado, input, true);
  }

  multiplicacao(lista1, lista2, resultado);
  print(resultado.valor);
  print(resultado.prox?.valor);
  print(resultado.prox?.prox?.valor);
  print(resultado.prox?.prox?.prox?.valor);

  saida(resultado);
}
