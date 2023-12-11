// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamestellar/favoritos.dart';
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
    child: HomePage(userEmail: '',),
  ),
));
}



class Noticia {
  final String id;
  final String titulo;
  final String imagemUrl;
  final String tag;
  bool favorito;

  Noticia({
    required this.id,
    required this.titulo,
    required this.imagemUrl,
    required this.tag,
    this.favorito = false,
  });
}

class HomePage extends StatefulWidget {
  final String userEmail; 
  const HomePage({Key? key, required this.userEmail}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

Widget buildNoticiaCard(BuildContext context, Noticia noticia, Function toggleFavorito) {
  return Card(
    color: Colors.black,
    child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () {
                    _navigateToNoticiaDetalhada(context, Noticia(
                      id: noticia.id,
                      titulo: noticia.titulo,
                      imagemUrl: noticia.imagemUrl,
                      tag: noticia.tag,
                    ));
                  },
                  child: Image.network(noticia.imagemUrl),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  noticia.favorito ? Icons.favorite : Icons.favorite_border,
                  color: noticia.favorito ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  toggleFavorito(noticia);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            noticia.titulo,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(152, 255, 255, 255),
              ),
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

void _navigateToNoticiaDetalhada(BuildContext context, Noticia noticia) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => NoticiaDetalhada(noticia: noticia),
    ),
  );
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Home';
  List<Noticia> noticiasList = [];

    void toggleFavorito(Noticia noticia) {
    setState(() {
      noticia.favorito = !noticia.favorito;
    });
    FirebaseFirestore.instance
      .collection('Games')
      .doc(noticia.id)
      .update({'Favorito': noticia.favorito});
  }
  

  @override
  void initState() {
    super.initState();
    fetchAndSetNoticias();
  }

  void fetchAndSetNoticias() async {
    List<Noticia> noticias = await fetchNoticias();

    setState(() {
      noticiasList = noticias;
    });
  }

  void updateNewsList(String category) async {
    Navigator.pop(context); 

    setState(() {
      selectedCategory = category;
    });

    List<Noticia> noticias = await fetchNoticias();

    noticias = noticias.where((noticia) => noticia.tag == selectedCategory).toList();

    setState(() {
      noticiasList = noticias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      body: buildBody(),
    );
  }


Widget buildDrawer(BuildContext context) {
  final drawerHeader = UserAccountsDrawerHeader(
    decoration: const BoxDecoration(
      color:  Color.fromRGBO(97, 87, 132, 1.0),
    ),
    accountEmail: Text(widget.userEmail),
    accountName: Text(''),
    currentAccountPicture: const CircleAvatar(
      child: Icon(Icons.person, size: 42.0),
    ),
  );

  return buildCommonDrawer(context, [
    drawerHeader,
    ListTile(
      title: const Text('Home', style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    ListTile(
      title: const Text('Tags', style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        _showTagsDrawer(context);
      },
    ),
    ListTile(
      title: const Text('Sair', style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
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
  ]);
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
              backgroundColor: const Color.fromARGB(111, 6, 5, 5),
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
                icon: const Icon(Icons.favorite),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritosPage()),
                    );
                  },
                ),
              ],
              floating: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (noticiasList.isEmpty) {
                    return const CircularProgressIndicator();
                  // ignore: unnecessary_null_comparison
                  } else if (noticiasList[index] == null) {
                    return const Text("Erro ao carregar notícias");
                  } else {
                    final noticia = noticiasList[index];
                    return buildNoticiaCard(context, noticia, toggleFavorito);
                  }
                },
                childCount: noticiasList.isEmpty ? 1 : noticiasList.length,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showTagsDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return buildCommonDrawer(context, [
          ListTile(
            title: const Text('Dicas', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Dicas');
            },
          ),
          ListTile(
            title: const Text('Games', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Games');
            },
          ),
          ListTile(
            title: const Text('Listas', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Listas');
            },
          ),
          ListTile(
            title: const Text('Mobile', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Mobile');
            },
          ),
          ListTile(
            title: const Text('Previews', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Previews');
            },
          ),
          ListTile(
            title: Text('Cultura Pop', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Cultura Pop');
            },
          ),
          ListTile(
            title: const Text('Voltar', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
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
  final collectionNames = ['Games', 'Especiais', 'Reviews' , 'Mobile', 'Dicas', 'Entrevistas', 'Cultura Pop', 'Previews', 'Listas'];
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