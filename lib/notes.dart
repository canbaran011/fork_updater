// import 'package:flutter/material.dart';
// import 'dart:io';

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   String output = '';

//   @override
//   void initState() {
//     super.initState();
//     runCommand(
//         'git status'); // Example command, replace with your desired command
//   }

//   void runCommand(String command) {
//     Process.run(command, [], runInShell: true).then((ProcessResult results) {
//       setState(() {
//         output = results.stdout as String;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Text(output,
//               style: const TextStyle(
//                 color: Colors.amber,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w300,
//                 decoration: TextDecoration.none,
//               )),
//         ),
//       ),
//     );
//   }
// }

    // for (var element in commandList) {
    //   folderPath.value = folderPath.value.replaceAll(r'\', r'\\');
    //   commandOutput.value += await executePowerShellCommand(
    //       element == commandList[0] ? (element + folderPath.value) : element);
    //   // runCommand(element);
    //   // if (commandList[0] == element) {
    //   //   runCommand('$element ${folderPath.value}');
    //   // } else {
    //   //   runCommand(element);
    //   // }
    // }


      // void runCommand(String command) async {
  //   try {
  //     await Process.run(command, [], runInShell: true)
  //         .then((ProcessResult results) {
  //       commandOutput.value += ('\n =>>> $command \n ${results.stdout}');
  //     });
  //     await Future.delayed(Duration(seconds: 5));
  //     // commandOutput.value = '';
  //     print('Function executed after 5 seconds');
  //   } catch (error) {
  //     Get.snackbar("ERROR ", error.toString(),
  //         colorText: Colors.white,
  //         backgroundColor: Colors.red,
  //         duration: const Duration(seconds: 5));
  //   }
  // }

import 'dart:convert';
import 'dart:io'; 

void main() async {
  // PowerShell'i başlat
  var process = await Process.start('powershell.exe', []);

  // PowerShell'in çıktısını okumak için bir stream oluştur
  process.stdout.transform(utf8.decoder).listen((data) {
    print(data);
  });

  // PowerShell'de çalışacak komutlar
  List<String> commands = [
    'cd D:/SourceRepos/RnEksisozluk', // PowerShell'de dizini değiştir
    'git status', // İlk komut
    'pwd', // İkinci komut
    // diğer komutlar...
  ];

  // Komutları PowerShell'e yaz
  for (var command in commands) {
    process.stdin.writeln(command);
  }

  // Çıkış kodunu al ve işlemi sonlandır
  process.exitCode.then((value) {
    print('PowerShell işlemi tamamlandı, çıkış kodu: $value');
    process.kill(); // İşlemi sonlandır
  });
}
