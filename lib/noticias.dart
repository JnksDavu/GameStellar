// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamestellar/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';


//IMAGEM

// ignore: camel_case_types
class Noticia_Imagem extends StatelessWidget {
  const Noticia_Imagem({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Games').doc('2').get(),
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
            // Obtenha a URL da imagem como uma string
            String imageUrl = data['Img'];
            // Utilize o Image.network para exibir a imagem da URL do Firestore
            return Image.network(imageUrl);
          } else {
            return const Text("URL da imagem não encontrada");
          }
        }

        return const Text("Carregando");
      },
    );
  }
}

//TAGS
// ignore: camel_case_types
class Noticia_Tag extends StatelessWidget {
  const Noticia_Tag({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Games').doc('2').get(),
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



//TITULO
// ignore: camel_case_types
class Noticia_Titulo extends StatelessWidget {
  const Noticia_Titulo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Games').doc('2').get(),
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
}




//TEXTO
class NoticiaTexto extends StatelessWidget {
  const NoticiaTexto({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Games').doc('2').get(),
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
}