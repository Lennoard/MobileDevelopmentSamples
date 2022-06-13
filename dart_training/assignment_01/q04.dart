void main() {
  double readjustSalary(double salary, int percent) {
    var amount = (salary * percent) / 100;
    return salary + amount;
  }

  var currentSalary = 4206.9;
  for (var i in [7, 6, 5]) {
    currentSalary = readjustSalary(currentSalary, i);
    print("Salário atual: $currentSalary");
  }
}
