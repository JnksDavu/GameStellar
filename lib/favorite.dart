import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:gamestellar/home_page.dart';
import 'package:gamestellar/noticias.dart';

class FavoritePage extends StatelessWidget {
  final List<Noticia> favoritasList;

  FavoritePage({required this.favoritasList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final favoritasList = FavoritesProvider.of(context)?.favoritosList ?? [];

    if (favoritasList.isEmpty) {
      return Center(
        child: Text('Nenhuma notícia favorita.'),
      );
    }

    return ListView.builder(
      itemCount: favoritasList.length,
      itemBuilder: (context, index) {
        final noticia = favoritasList[index];
        return buildNoticiaCard(context, noticia);
      },
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
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                onTap: () {
                  // Adicione a navegação para a página detalhada aqui se necessário
                },
                child: Image.network(noticia.imagemUrl, fit: BoxFit.cover),
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
}