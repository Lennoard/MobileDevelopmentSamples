
// Crie uma função que receba um array e retorne a multiplicação de todos os elementos;


void main() {
  var array = [1, 2, 3, 4];

  var sumFunction = (int n1, int n2) {
    return n1 + n2;
  };

  var multiplyFunction = (int n1, int n2) {
    return n1 * n2;
  };

  print(highOrderArray(array, sumFunction));
  print(highOrderArray(array, multiplyFunction));
}

int highOrderArray(List<int> array, int Function(int, int) f) {
  int result = 0;
  for (var i = 0; i < array.length; i++) {
    var element = array[i];
    var previous = i == 0 ? null : array[i - 1];
    if (previous == null) continue;

    result += f(previous, result);
  }

  return result;
}