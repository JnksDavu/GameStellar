//import 'dart:js_interop';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gamestellar/register.dart';
import 'home_page.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
              // Image.asset(
              //   'images/GameStellar.png', // Substitua pelo caminho correto da sua imagem
              //   width: 500,
              //   height: 200,
              // ),
              const SizedBox(width: 1),
              Image.asset(
                'images/Asteroids.gif', // Substitua pelo caminho correto da sua imagem
                height: 100,
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
                  hintText: 'usuário',
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

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 16.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Text(
                          'Salvar',
                          style: TextStyle(
                            // Estilo de texto personalizado para o botão Switch
                            fontSize: 16, // Tamanho da fonte
                            fontWeight:
                                FontWeight.bold, // Peso da fonte (opcional)
                            color: Color.fromARGB(
                                185, 255, 255, 255), // Cor da fonte
                          ),
                        ),
                        Switch(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value;
                            });
                          },
                          activeColor: const Color.fromRGBO(156, 39, 176, 1),
                        ),
                      ],
                    ),
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
                                    const RegisterPage(),
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
                    const SizedBox(
                        height: 10), // Espaço entre a linha e a caixa de texto

                    const Text(
                      'Entrar Com ',
                      style: TextStyle(
                        color: Color.fromARGB(
                            158, 155, 39, 176), // Cor do texto informativo
                        fontSize: 16, // Tamanho do texto
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Alinhamento do texto
                    ),
                    const Divider(
                      height: 1, // Altura da linha
                      thickness: 1, // Espessura da linha
                      color:
                          Color.fromARGB(255, 50, 5, 173), // Cor da linha
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Lógica para login com Google
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(
                                150, 255, 0, 76)), // Cor do botão do Google
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Raio dos cantos (ajuste conforme necessário)
                          ),
                        ),
                      ),
                      icon: const Icon(Icons
                          .email), // Ícone do Google (substitua pelo ícone correto)
                      label: const Text('Google'),
                    ), // Espaço entre a linha e a caixa de texto

                    const SizedBox(height: 7), // Espaço entre os botões
                    ElevatedButton.icon(
                      onPressed: () {
                        // Lógica para login com Facebook
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(
                                255, 39, 0, 211)), // Cor do botão do Facebook
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Raio dos cantos (ajuste conforme necessário)
                          ),
                        ),
                      ),
                      icon: const Icon(Icons
                          .facebook), // Ícone do Facebook (substitua pelo ícone correto)
                      label: const Text('Facebook'),
                    ),
                    const SizedBox(height: 7), // Espaço entre os botões
                    ElevatedButton.icon(
                      onPressed: () {
                        // Lógica para login com Facebook
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(
                                255, 51, 51, 51)), // Cor do botão do Facebook
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Raio dos cantos (ajuste conforme necessário)
                          ),
                        ),
                      ),
                      icon: const Icon(Icons
                          .apple), // Ícone do Facebook (substitua pelo ícone correto)
                      label: const Text('ID Apple'),
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
