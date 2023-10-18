//import 'dart:js_interop';
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gamestellar/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/Estrelas.gif'), // Substitua pelo caminho correto do seu GIF
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Cadastro',
                style: TextStyle(
                    color: Color.fromARGB(87, 255, 255, 255),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                // style: GoogleFonts.tiltNeon(color: Color.fromARGB(132, 255, 255, 255),fontSize: 25,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'email',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(87, 255, 255, 255)),
                  filled: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 50, 5,
                            173)), // Substitua "Colors.red" pela cor desejada
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'confirmar email',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(87, 255, 255, 255)),
                  filled: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 50, 5,
                            173)), // Substitua "Colors.red" pela cor desejada
                  ),
                ),
              ),
              const SizedBox(height: 10), // Espaço entre os campos de entrada
              TextFormField(
                autofocus: true,
                obscureText: !_showPassword,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'senha',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(87, 255, 255, 255)),
                  filled: true,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 50, 5,
                            173)), // Substitua "Colors.red" pela cor desejada
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(87, 255, 255, 255),
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                autofocus: true,
                obscureText: !_showPassword,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'confirmar senha',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(87, 255, 255, 255)),
                  filled: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 50, 5,
                            173)), // Substitua "Colors.red" pela cor desejada
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 16.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HomePage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0,
                                  0.0); // aqui ta sendo definida a posição inicial da tela
                              const end =
                                  Offset.zero; // aqui é a posição final da tela
                              const curve = Curves
                                  .easeInOut; // aqui ele define uma curva?? pra animação

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                        // Coloque a função de autenticação aqui
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 68, 0, 255)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Raio dos cantos (ajuste conforme necessário)
                          ),
                        ),
                      ),
                      child: const Text('Logar'),
                    ),
                    const SizedBox(height: 10), // Espaço entre os botões
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0,
                                  0.0); // aqui ta sendo definida a posição inicial da tela
                              const end =
                                  Offset.zero; // aqui é a posição final da tela
                              const curve = Curves
                                  .easeInOut; // aqui ele define uma curva?? pra animação

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(
                                255, 84, 0, 117)), // Cor do segundo botão
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Raio dos cantos (ajuste conforme necessário)
                          ),
                        ),
                      ),
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
