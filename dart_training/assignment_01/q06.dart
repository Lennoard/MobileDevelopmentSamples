void main() {
  var n1 = 7.6;
  var n2 = 6.2;
  var n3 = 6.7;

  var average = (n1 + n2 + n3) / 3.0;

  if (average >= 7) {
    print("Aprovado");
  } else if (average < 4) {
    print("Reprovado");
  } else {
    print("Exame final");
  }

  print(average);
}
