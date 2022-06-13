import 'dart:math';

void main() {
  var n1 = 7;
  var n2 = 3;

  var remainder = n1 % n2;
  print(remainder);

  var intDiv = n1 ~/ n2;
  print(intDiv);

  var power = pow(n2, n1);
  print(power);

  print("$n1 é inteiro? ${n1 is int}");
  print("$n1 não é inteiro? ${n1 is! int}");
}
