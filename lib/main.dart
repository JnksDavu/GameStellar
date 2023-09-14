import 'package:flutter/material.dart';
import 'package:gamestellar/login.dart';
import 'app.dart';

void main() {
  runApp(MyApp());
  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'GameStellar',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: LoginPage(),
      

    );
  }
}
// O Comentado abaixo é igual ao pc do GUSTAVO (GENERETE (davi))
//Comentei para Rodar a tela de Login por Primeiro
/*  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('bom dia'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Planeta.png'),
              //fit: BoxFit.cover, // Para cobrir toda a tela
            ),
          ),
        ),
      ),
    );
  }
}
*/