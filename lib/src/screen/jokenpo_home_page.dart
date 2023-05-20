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
  String _previousComputerChoice = '';

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
      } while (_choices[computerIndex] == _playerChoice || _choices[computerIndex] == _previousComputerChoice);

      _previousComputerChoice = _computerChoice;
      _computerChoice = _choices[computerIndex];
      print('PC => atual: $_computerChoice | anterior: $_previousComputerChoice');

      _result = _getResult(_playerChoice, _computerChoice)!;
    });
  }

  String? _getResult(String playerChoice, String computerChoice) {
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
            const Text(
              'Escolha sua jogada:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _playGame('Pedra'),
                  child: const Text('Pedra'),
                ),
                ElevatedButton(
                  onPressed: () => _playGame('Papel'),
                  child: const Text('Papel'),
                ),
                ElevatedButton(
                  onPressed: () => _playGame('Tesoura'),
                  child: const Text('Tesoura'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Você escolheu: $_playerChoice',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'O computador escolheu: $_computerChoice',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              _result,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
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
