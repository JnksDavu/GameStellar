import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamestellar/home_page.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<Noticia> noticiasFavoritasList = [];

  @override
  void initState() {
    super.initState();
    fetchAndSetNoticiasFavoritas();
  }

  void toggleFavorito(Noticia noticia) {
    setState(() {
      noticia.favorito = !noticia.favorito;
      if (!noticia.favorito) {
        noticiasFavoritasList.remove(noticia);
      }
    });
    FirebaseFirestore.instance
        .collection('Games')
        .doc(noticia.id)
        .update({'Favorito': noticia.favorito});
  }

  void fetchAndSetNoticiasFavoritas() async {
    List<Noticia> noticias = await fetchNoticiasFavoritas();

    setState(() {
      noticiasFavoritasList = noticias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
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
              title: const Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Center(
                  child: Text(
                    'Notícias Favoritas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildNoticiaCard(
                      context, noticiasFavoritasList[index], toggleFavorito);
                },
                childCount: noticiasFavoritasList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Noticia>> fetchNoticiasFavoritas() async {
    final firestore = FirebaseFirestore.instance;
    final collectionNames = [
      'Games',
      'Especiais',
      'Reviews',
      'Mobile',
      'Dicas',
      'Entrevistas',
      'Cultura Pop',
      'Previews',
      'Listas'
    ];
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
          favorito: data['Favorito'] ?? false,
        );
      }).toList();

      allNoticias.addAll(noticias);
    }

    final noticiasFavoritas =
        allNoticias.where((noticia) => noticia.favorito).toList();

    return noticiasFavoritas;
  }
}
