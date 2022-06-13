import 'Funcionario.dart';
import 'IAutenticavel.dart';

class Diretor extends Funcionario implements IAutenticavel {
  @override
  double getBonificacao() {
    return salario * 0.13;
  }

  @override
  bool autentica(String login, String senha) {
    return login == 'usuario' && senha == 123;
  }
}
