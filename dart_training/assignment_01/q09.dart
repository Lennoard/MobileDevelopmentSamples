class Person {
  String name = "Pessoa padrão";
  int age = 18;
}

List<Person>? getPeople() {
  return null;
}

void printPerson(Person person) {
  print("A pessoa ${person.name} tem ${person.age} anos de idade.");
}

void main() {
  var people = getPeople();

  var maybeFirstPerson = people?.first;
  var maybeTheirName = maybeFirstPerson?.name;

  var safeName = maybeTheirName ?? "Lennoard";
  var safePerson = maybeFirstPerson ?? new Person();
  printPerson(maybeFirstPerson!);
}
