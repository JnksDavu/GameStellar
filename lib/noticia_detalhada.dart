// ignore_for_file: unused_import

import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamestellar/home_page.dart';
import 'package:gamestellar/firebase_options.dart';
import 'package:gamestellar/login.dart';
import 'package:gamestellar/register.dart';
import 'noticias.dart';
import 'package:dio/dio.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Directionality(
    textDirection: TextDirection.ltr,
    child: NoticiaDetalhada(),
    // Crie um widget MyApp para envolver todas as classes
  ));
}



class NoticiaDetalhada extends StatelessWidget {
  const NoticiaDetalhada({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            const Color.fromARGB(226, 0, 0, 0), // Define o fundo como preto
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Drawer(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: const Color.fromARGB(232, 0, 0, 0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Home'),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                      },
                    ),
                    ListTile(
                      title: const Text('E-sports'),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                        // Navegue para a página "E-sports" aqui
                      },
                    ),
                    ListTile(
                      title: const Text('Tags'),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                        // Navegue para a página "Tags" aqui
                      },
                    ),
                    ListTile(
                      title: const Text('Sair'),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 60,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'images/appbar.png',
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: const Color.fromARGB(105, 6, 5, 5),
              title: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Image.asset('images/logo.png', height: 50),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    print('Pesquisar');
                  },
                ),
              ],
              floating: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Noticia_Imagem(),
                  const SizedBox(
                      height: 16.0), // Espaço vertical entre imagem e título
                  Container(
                    width: 300, // Largura desejada
                    height: 140, // Altura desejada
                    color: const Color.fromARGB(232, 134, 61, 202), // Defina a cor de fundo roxo claro aqui
                    alignment: Alignment.center,
                    child: const Column(
                      children: [
                        Noticia_Titulo(),
                        Noticia_Tag(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const NoticiaTexto(),
                  // Adicione outros widgets do conteúdo aqui
                ],
              ),
            ),
          ],
        ),
      ),
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