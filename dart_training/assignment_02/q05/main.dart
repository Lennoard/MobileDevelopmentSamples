import 'Cliente.dart';
import 'Gerente.dart';
import 'IAutenticavel.dart';

void main() {
  Gerente g = Gerente(4500, 'g@company.com', '123456', 0.5);
  var gAuth = performAuth(g, 'g@company.com', '123456');

  Gerente h = Gerente.auth('h@company.com', '654321');
  var hAuth = performAuth(h, 'h@company.com', '123456');

  Cliente c = Cliente();
  var cAuth = performAuth(c, 'c@gmail.com', 'f32@saO');

  print(g.getBonificacao());
  print(h.getBonificacao());
  print('G autenticado? $gAuth');
  print('H autenticado? $hAuth');
  print('C autenticado? $cAuth');
}

bool performAuth(IAutenticavel auth, String login, String password) {
  return auth.autentica(login, password);
}
