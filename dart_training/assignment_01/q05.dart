void main() {
  /**
   * Qual o resultado da operação abaixo:
   * void main() {
      var a = null;
      var b = 12;
      var res = a ?? b;
      print(res);
      }
   */

  print("""
    O resultado é 12 pois o operador ?? pega o lado esquerdo da espressão como
    resultado somente se este não for nulo, que não é o caso de "a", portanto
    o lado direito é avaliado como resultado.
  """);
}
