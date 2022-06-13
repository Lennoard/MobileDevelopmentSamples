
// Crie uma função que receba um array e retorne a soma de todos os elementos.s

void main() {
  var array = [1, 2, 3, 4];
  print(soma(array));
}

int soma(List<int> array) {
  return array.fold(0, (previousValue, element) => previousValue + element);
}