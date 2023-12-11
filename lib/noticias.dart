// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamestellar/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';


//IMAGEM

class Noticia_Imagem extends StatelessWidget {
  final String noticiaId;
  final List<String> collectionName;

  const Noticia_Imagem({required this.noticiaId, required this.collectionName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _fetchDocumentInCollections(noticiaId, collectionName),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Algo deu errado");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("O documento não existe");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null && data['Img'] != null) {
            String imageUrl = data['Img'];
            return Image.network(imageUrl);
          } else {
            return const Text("URL da imagem não encontrada");
          }
        }

        return const Text("Carregando");
      },
    );
  }

  Future<DocumentSnapshot> _fetchDocumentInCollections(String noticiaId, List<String> collectionName) async {
    late DocumentSnapshot documentSnapshot;

    for (final collectionName in collectionName) {
      documentSnapshot = await FirebaseFirestore.instance.collection(collectionName).doc(noticiaId).get();

      if (documentSnapshot.exists) {
        break;
      }
    }

    return documentSnapshot;
  }
}


 //toda essa palhaçada deveria estar na noticia_detalhada, mas eu fiz cagada e coloquei aqui, perdão pelo vacilo rs

//TAGS
class Noticia_Tag extends StatelessWidget {
  final String noticiaId;
  final List<String> collectionName;

  const Noticia_Tag({required this.noticiaId, required this.collectionName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _fetchDocumentInCollections(noticiaId, collectionName),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Algo deu errado");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("O documento não existe");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
          final tagText = data?['Tag'] ?? 'Texto não existe';

          return Container(
            alignment: Alignment.center, 
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(152, 255, 255, 255)), 
            ),
            height: 40.0, 
            child: Text(
              tagText,
              style: const TextStyle(fontSize: 16.0, color: Colors.white), 
            ),
          );
        }

        return const Text("Carregando");
      },
    );
  }
}


  Future<DocumentSnapshot> _fetchDocumentInCollections(String noticiaId, List<String> collectionName) async {
    late DocumentSnapshot documentSnapshot;

    for (final collectionName in collectionName) {
      documentSnapshot = await FirebaseFirestore.instance.collection(collectionName).doc(noticiaId).get();

      if (documentSnapshot.exists) {
        break;
      }
    }

    return documentSnapshot;
  }


//TITULO
class Noticia_Titulo extends StatelessWidget {
  final String noticiaId;
  final List<String> collectionName;

  const Noticia_Titulo({required this.noticiaId, required this.collectionName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _fetchDocumentInCollections(noticiaId, collectionName),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Algo deu errado");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("O documento não existe");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;
          final tituloText = data?['Titulo'] ?? 'Texto não existe';

          return Container(
            width: 300, 
            height: 100, 
            alignment: Alignment.center,
            child: Text(
              tituloText,
              style: const TextStyle(fontSize: 18.0, color: Colors.white, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Container(
          alignment: Alignment.center,
          child: const Text("Carregando"),
        );
      },
    );
  }

  Future<DocumentSnapshot> _fetchDocumentInCollections(String noticiaId, List<String> collectionName) async {
    late DocumentSnapshot documentSnapshot;

    for (final collectionName in collectionName) {
      documentSnapshot = await FirebaseFirestore.instance.collection(collectionName).doc(noticiaId).get();

      if (documentSnapshot.exists) {
        break;
      }
    }

    return documentSnapshot;
  }
}




//TEXTO
class NoticiaTexto extends StatelessWidget {
  final String noticiaId;
  final List<String> collectionName;

  const NoticiaTexto({required this.noticiaId, required this.collectionName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _fetchDocumentInCollections(noticiaId, collectionName),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Algo deu errado");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("O documento não existe");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
          final textoContent = data?['Texto'] ?? ''; 
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text(
              textoContent,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 192, 192, 192),
                height: 1.9,
                ),
              ),
            ),
          );
        }

        return const Text("Carregando");
      },
    );
  }

  Future<DocumentSnapshot> _fetchDocumentInCollections(String noticiaId, List<String> collectionName) async {
    late DocumentSnapshot documentSnapshot;

    for (final collectionName in collectionName) {
      documentSnapshot = await FirebaseFirestore.instance.collection(collectionName).doc(noticiaId).get();

      if (documentSnapshot.exists) {
        break;
      }
    }

    return documentSnapshot;
  }
}

