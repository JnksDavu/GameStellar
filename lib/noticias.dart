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

//IMAGEM COM PROXY
/*
class Noticia_Imagem extends StatelessWidget {
  Future<Widget> _fetchImage() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Games').doc('1').get();
      if (!snapshot.exists) {
        return Text("O documento não existe");
      }

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null && data['Img'] != null) {
        String imageUrl = data['Img'];
        String proxyUrl = 'http://10.0.2.2:3000/img/';
        Dio dio = Dio();
        final response = await dio.get(proxyUrl + imageUrl, options: Options(responseType: ResponseType.bytes));

        if (response.statusCode == 200) {
          return Image.memory(response.data);
        } else {
          return Text("Falha ao carregar a imagem - Status Code: ${response.statusCode}");
        }
      } else {
        return Text("URL da imagem não encontrada");
      }
    } catch (e) {
      print("Erro ao buscar documento: $e");
      return Text("Erro ao buscar o documento");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _fetchImage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data ?? Text("Erro desconhecido");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
*/




//TAG
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