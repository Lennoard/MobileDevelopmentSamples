
// Crie duas versões de uma função que eleva um número (base) a outro (expoente):
// a primeira versão é a tradicional, já a segunda deve ser uma arrow function.

import 'dart:math';

void main() {
  var reg = regularFunction(2, 8);
  var arrow = arrowFunction(2, 8);

  print(reg);
  print(arrow);
}

var arrowFunction = (int number, int exponent) => pow(number, exponent);

num regularFunction(int number, int exponent) {
  return pow(number, exponent);
}