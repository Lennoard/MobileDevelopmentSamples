import 'IAutenticavel.dart';

class Cliente implements IAutenticavel {
  @override
  bool autentica(String login, String senha) {
    return login == 'usuario' && senha == 123;
  }
}
