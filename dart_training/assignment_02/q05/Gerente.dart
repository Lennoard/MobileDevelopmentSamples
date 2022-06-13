import 'Funcionario.dart';
import 'IAutenticavel.dart';

class Gerente extends Funcionario implements IAutenticavel {
  String _login = "";
  String _senha = "";
  double _porcentagemParticipacao = 0.0;

  Gerente(double salario, String login, String senha,
      double porcentagemParticipacao) {
    this.salario = salario;
    this._login = login;
    this._senha = senha;
    this._porcentagemParticipacao = porcentagemParticipacao;
  }

  Gerente.auth(String login, String senha) {
    this._login = login;
    this._senha = senha;
  }

  String get login => _login;
  String get senha => _senha;
  double get porcentagemParticipacao => _porcentagemParticipacao;

  set login(String s) {
    _login = s;
  }

  set senha(String s) {
    _senha = s;
  }

  set porcentagemParticipacao(double d) {
    _porcentagemParticipacao = d;
  }

  @override
  double getBonificacao() {
    return _acrescimoPct(salario, porcentagemParticipacao);
  }

  @override
  bool autentica(String login, String senha) {
    return this.login == login && this.senha == senha;
  }

  double _acrescimoPct(double d, double pct) {
    return d + ((d * pct) / 100);
  }
}
