import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var checks = [false, false, false];

  @override
  Widget build(BuildContext context) {
    bool? tristateValue = false;

    if (checks.contains(true) && !checks.every((element) => element == true)) {
      tristateValue = null;
    } else {
      tristateValue = checks.every((element) => element == true) ? true : false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkboxes'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
                'Isso informa nossas políticas sobre a coleta, uso e divulgação de dados pessoais quando você usa nosso serviço e as opções que você associou a esses dados.'),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  'Usamos seus dados para fornecer e melhorar o Serviço. Ao usar o Serviço, você concorda com a coleta e uso de informações de acordo com esta política. A menos que definido de outra forma nesta Política de Privacidade, os termos usados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições.'),
            ),
            buildCheckboxRow('Aceito compartilhar dados para melhoria do aplicativo', 0),
            buildCheckboxRow('Aceito coletar informações', 1),
            buildCheckboxRow('Entendo que posso solicitar a entrega ou exclusão de meus dados', 2),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  const Expanded(child: Text('Aceitar todos os itens acima')),
                  Checkbox(
                    value: tristateValue,
                    tristate: true,
                    onChanged: (checked) {
                      var c = checked ?? false;
                      setState(() {
                        checks = [c, c, c];
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildCheckboxRow(String text, int index) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Checkbox(
          value: checks[index],
          onChanged: (checked) {
            setState(() {
              checks[index] = checked ?? false;
            });
          },
        )
      ],
    );
  }
}
