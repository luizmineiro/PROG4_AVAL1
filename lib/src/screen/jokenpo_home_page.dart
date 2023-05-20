// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

class JokenpoHomePage extends StatefulWidget {
  const JokenpoHomePage({super.key});

  @override
  _JokenpoHomePageState createState() => _JokenpoHomePageState();
}

class _JokenpoHomePageState extends State<JokenpoHomePage> {
  String _result = '';
  String _playerChoice = '';
  String _computerChoice = '';
  String _previousComputerChoice = "";
  var _imagemApp = const AssetImage("assets/images/padrao.png");

  final List<String> _choices = ['Pedra', 'Papel', 'Tesoura'];

  void _playGame(String playerChoice) {
    setState(() {
      if (_playerChoice == playerChoice) {
        _result = 'Escolha outro gesto!';
        return;
      }

      print('Usuário => atual: $playerChoice | anterior: $_playerChoice');
      _playerChoice = playerChoice;

      final Random random = Random();
      int computerIndex;
      do {
        computerIndex = random.nextInt(3);
      } while (_choices[computerIndex] == _playerChoice ||
          _choices[computerIndex] == _previousComputerChoice);

      _previousComputerChoice = _computerChoice;
      _computerChoice = _choices[computerIndex];
      print(
          'PC => atual: $_computerChoice | anterior: ${_previousComputerChoice}');

      _result = _getResult(_playerChoice, _computerChoice)!;
    });
  }

  String? _getResult(String playerChoice, String computerChoice) {
    //Exibição da imagem escolhida pelo App
    switch (_computerChoice) {
      case "Pedra":
        setState(() {
          _imagemApp = const AssetImage("assets/images/rock.png");
        });
        break;
      case "Papel":
        setState(() {
          _imagemApp = const AssetImage("assets/images/paper.png");
        });
        break;
      case "Tesoura":
        setState(() {
          _imagemApp = const AssetImage("assets/images/scissors.png");
        });
        break;
    }

    Map<String, String> resultMappings = {
      'PedraTesoura': 'Você venceu!',
      'PapelPedra': 'Você venceu!',
      'TesouraPapel': 'Você venceu!',
      'PedraPapel': 'Você perdeu!',
      'PapelTesoura': 'Você perdeu!',
      'TesouraPedra': 'Você perdeu!',
    };

    if (playerChoice == computerChoice) {
      return 'Empate!';
    }

    String key = playerChoice + computerChoice;
    return resultMappings.containsKey(key) ? resultMappings[key] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokenpo Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                "Escolha do App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image(
              image: _imagemApp,
              height: 125,
            ),
            const Text(
              'Escolha sua jogada:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _playGame('Pedra'),
                  child: Image.asset('assets/images/rock.png', height: 95),
                ),
                GestureDetector(
                  onTap: () => _playGame('Papel'),
                  child: Image.asset('assets/images/paper.png', height: 95),
                ),
                GestureDetector(
                  onTap: () => _playGame('Tesoura'),
                  child: Image.asset('assets/images/scissors.png', height: 95),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              _result,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 180,
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: Column(
                  children: [],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
        child: const Icon(Icons.replay_sharp),
      ),
    );
  }
}
