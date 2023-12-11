import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamestellar/home_page.dart';
import 'package:gamestellar/noticias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Noticia minhaNoticia = Noticia(id: '0', titulo: 'Título', imagemUrl: 'url', tag: 'Tag',);

  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: NoticiaDetalhada(noticia: minhaNoticia), 
    ),
  );
}

class NoticiaDetalhada extends StatelessWidget {
  final Noticia noticia;

  NoticiaDetalhada({required this.noticia, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black, 
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Drawer(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black87,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Home'),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                     const HomePage(userEmail: '',),
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
              backgroundColor: Colors.black87,
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
                  Noticia_Imagem(noticiaId: noticia.id, collectionName: const ['Especiais', 'Games', 'Dicas', 'Cultura Pop', 'Listas']),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(232, 134, 61, 202),
                          Color.fromARGB(232, 74, 20, 140),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Noticia_Titulo(noticiaId: noticia.id, collectionName: const  ['Especiais', 'Games', 'Dicas', 'Cultura Pop', 'Listas']),
                        Noticia_Tag(noticiaId: noticia.id, collectionName: const ['Especiais', 'Games', 'Dicas', 'Cultura Pop', 'Listas']),
                      ],
                    ),
                  ),
                 const SizedBox (height: 20.0),
                    NoticiaTexto(noticiaId: noticia.id, collectionName: const ['Especiais', 'Games', 'Dicas', 'Cultura Pop', 'Listas']),
                ],
              ),
            ),

          ],  
        ),
      ),
    );
  }
}