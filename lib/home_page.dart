// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamestellar/firebase_options.dart';
import 'package:gamestellar/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamestellar/noticia_detalhada.dart';
import 'dart:ui';
import 'package:gamestellar/noticias.dart';
import 'package:gamestellar/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaterialApp(
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: HomePage(),
    ),
  ));
}



class Noticia {
  final String id;
  final String titulo;
  final String imagemUrl;
  final String tag;

  Noticia({
    required this.id,
    required this.titulo,
    required this.imagemUrl,
    required this.tag,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      body: buildBody(),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return buildCommonDrawer(context, [
      ListTile(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        onTap: () {},
      ),
      ListTile(
        title: Text('E-sports', style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.pop(context);
          // Navegue para a página "E-sports" aqui
        },
      ),
      ListTile(
        title: Text('Tags', style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.pop(context);
          _showTagsDrawer(context);
        },
      ),
      ListTile(
        title: Text('Sair', style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginPage(),
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
    ]);
  }

  void _showTagsDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return buildCommonDrawer(context, [
          ListTile(
            title: Text('Dicas', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle 'Dicas' selection
            },
          ),
          ListTile(
            title: Text('Games', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle 'Games' selection
            },
          ),
          ListTile(
            title: Text('Listas', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle 'Listas' selection
            },
          ),
          ListTile(
            title: Text('Mobile', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle 'Mobile' selection
            },
          ),
          ListTile(
            title: Text('Previews', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle 'Previews' selection
            },
          ),
          ListTile(
            title: Text('Voltar', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the tags drawer
            },
          ),
        ]);
      },
    );
  }

  Widget buildCommonDrawer(BuildContext context, List<Widget> children) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Drawer(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Color.fromARGB(232, 0, 0, 0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
Future<List<Noticia>> fetchNoticias() async {
  final firestore = FirebaseFirestore.instance;
  final collectionNames = ['Games', 'Especiais', 'Reviews' , 'Mobile', 'Dicas', 'Entrevistas', 'Cultura Pop', 'Previews', 'Listas']; // Substitua pelos nomes de suas coleções
  final List<Noticia> allNoticias = [];

  for (final collectionName in collectionNames) {
    final noticiasData = await firestore.collection(collectionName).get();

    final noticias = noticiasData.docs.map((doc) {
      final data = doc.data();
      return Noticia(
        id: doc.id,
        titulo: data['Titulo'] ?? 'Sem título',
        imagemUrl: data['Img'] ?? '',
        tag: data['Tag'] ?? 'Sem tag',
      );
    }).toList();

    allNoticias.addAll(noticias);
  }

  return allNoticias;
}

  Widget buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'images/appbar.png',
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Color.fromARGB(111, 6, 5, 5),
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FutureBuilder<List<Noticia>>(
                    future: fetchNoticias(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text("Erro ao carregar notícias");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text("Nenhuma notícia encontrada");
                      } else {
                        final noticia = snapshot.data![index];
                        return buildNoticiaCard(context, noticia);

                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }


Widget buildNoticiaCard(BuildContext context, Noticia noticia) {
  return Card(
    color: Colors.black,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 200.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NoticiaDetalhada()));
              },
              child: Image.network(noticia.imagemUrl),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            noticia.titulo,
            style: const TextStyle(fontSize: 18.0, color: Colors.white, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(152, 255, 255, 255)),
            ),
            height: 40.0,
            child: Text(
              noticia.tag,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

