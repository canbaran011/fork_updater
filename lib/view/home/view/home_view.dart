import 'package:flutter/material.dart';
import 'dart:io';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String output = '';

  @override
  void initState() {
    super.initState();
    runCommand(
        'git branch'); // Example command, replace with your desired command
  }

  void runCommand(String command) {
    Process.run(command, [], runInShell: true).then((ProcessResult results) {
      setState(() {
        output = results.stdout as String;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Text(
            output,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
