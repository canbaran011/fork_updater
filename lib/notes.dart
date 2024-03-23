import 'package:flutter/material.dart';
import 'dart:io';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String output = '';

  @override
  void initState() {
    super.initState();
    runCommand(
        'git status'); // Example command, replace with your desired command
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
          child: Text(output,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.none,
              )),
        ),
      ),
    );
  }
}
