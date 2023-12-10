// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamestellar/favorite.dart';
import 'package:gamestellar/firebase_options.dart';
import 'package:gamestellar/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamestellar/noticia_detalhada.dart';
import 'dart:ui';
import 'package:gamestellar/noticias.dart';
import 'package:gamestellar/register.dart';

// void main() async { //comentei pra testar se aparecia o email 
//   WidgetsFlutterBinding.ensureInitialized();  
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(
//     MaterialApp(
//       // Restante do código...
//       home: Directionality(
//         textDirection: TextDirection.ltr,
//         child: FavoritesProvider(
//           favoritosList: [], // Inicialize com a lista inicial de favoritos
//           child: HomePage(userEmail: userEmail.text,), 
//         ),
//       )
//     )
//   );
// }

class FavoritesProvider extends InheritedWidget {
  final List<Noticia> favoritosList;
  final Widget child;
  

  FavoritesProvider({
    required this.favoritosList,
    required this.child,
  }) : super(child: child);

  static FavoritesProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FavoritesProvider>();
  }

  void setFavoritos(List<Noticia> favoritos) {
    // Atualize o estado da lista de favoritos
    favoritosList.clear();
    favoritosList.addAll(favoritos);
  }

  @override
  bool updateShouldNotify(FavoritesProvider oldWidget) {
    return favoritosList != oldWidget.favoritosList;
  }
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
  final String userEmail; // Adicione este parâmetro

  const HomePage({Key? key, required this.userEmail}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  String selectedCategory = 'Home';
  List<Noticia> noticiasList = [];

  List<Noticia> favoritasList = [];

  void updateFavoritos(Noticia noticia) {
    // Update the state of the favoritosList with the updated state of the noticia
    setState(() {
      noticia.favorito = !noticia.favorito;
      List<Noticia> favoritos = noticiasList.where((not) => not.favorito).toList();

      // Update the state using the FavoritesProvider
      FavoritesProvider.of(context)?.setFavoritos(favoritos);
    });
  }

  @override
  void initState() {
    super.initState();
    // Buscar notícias quando a tela for construída pela primeira vez
    fetchAndSetNoticias();
  }

  void fetchAndSetNoticias() async {
    // Obtém as notícias da categoria selecionada
    List<Noticia> noticias = await fetchNoticias();

    // Atualiza o estado com as notícias
    setState(() {
      noticiasList = noticias;
    });
  }

  void updateNewsList(String category) async {
    Navigator.pop(context); // Fecha o Drawer

    // Atualiza o estado da categoria selecionada
    setState(() {
      selectedCategory = category;
    });

    // Obtém as notícias da categoria selecionada
    List<Noticia> noticias = await fetchNoticias();

    // Filtra as notícias com base na categoria selecionada
    noticias = noticias.where((noticia) => noticia.tag == selectedCategory).toList();

    // Atualiza o estado com as notícias filtradas
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
    decoration: BoxDecoration(
      color: Color.fromRGBO(97, 87, 132, 1.0),
    ),
    accountName: Text('Nome do Usuário'),
    accountEmail: Text(widget.userEmail),
    currentAccountPicture: const CircleAvatar(
      child: Icon(Icons.person, size: 42.0),
    ),
  );

  return buildCommonDrawer(context, [
    drawerHeader,
    ListTile(
      title: Text('Home', style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        // Adicione a lógica para navegar para a página "Home" aqui
      },
    ),
    ListTile(
      title: Text('E-sports', style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        // Adicione a lógica para navegar para a página "E-sports" aqui
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
                  icon: const Icon(Icons.favorite_border),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritePage(favoritasList: FavoritesProvider.of(context)!.favoritosList),
                      ),
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
                    return buildNoticiaCard(context, noticia, updateFavoritos);

                  }
                },
                childCount: noticiasList.length == 0 ? 1 : noticiasList.length,
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
            title: Text('Dicas', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Dicas');
            },
          ),
          ListTile(
            title: Text('Games', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Games');
            },
          ),
          ListTile(
            title: Text('Listas', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Listas');
            },
          ),
          ListTile(
            title: Text('Mobile', style: TextStyle(color: Colors.white)),
            onTap: () {
              updateNewsList('Mobile');
            },
          ),
          ListTile(
            title: Text('Previews', style: TextStyle(color: Colors.white)),
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
            title: Text('Voltar', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the tags drawer
            },
          ),
        ]);
      },
    );
  }

Widget buildNoticiaCard(BuildContext context, Noticia noticia, Function(Noticia) updateFavoritos) {
  return Card(
    color: Colors.black,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 200.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: InkWell(
              onTap: () {
                _navigateToNoticiaDetalhada(context, noticia);
              },
              child: Stack(
                children: [
                  Image.network(noticia.imagemUrl),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child:   IconButton(
                      icon: Icon(
                        noticia.favorito
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: noticia.favorito
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          noticia.favorito = !noticia.favorito;
                        });
                      }
                  ),
                  )
                ],
              ),
            ),
          ),
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

