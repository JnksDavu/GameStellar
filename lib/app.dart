import 'package:flutter/material.dart';
import 'package:gamestellar/login.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
//classe foda pra representar a noticia
class Noticia {
  final String title;
  final String imageUrl;

  Noticia({required this.title, required this.imageUrl});
}

//classe mais foda pra criar a noticia
List<Noticia> NoticiaList = [
  Noticia(
    title: 'Mc estudo se formou com 15 diplomas na cabeça ',
    imageUrl: 'images/mcestudo.jpg',
  ),
  Noticia(
    title: 'Mc estupro morreu com 15 tiros na cabeça',
    imageUrl: 'images/mcestudo2.jpg',
  ),
  Noticia(
    title: 'AMC confirma que Walter White trocou seu nome para Valter Zap',
    imageUrl: 'images/breakingbad.jpg',
  ),
  Noticia(
    title: 'Vaza gameplay de Resident Evil 8 no novo iphone',
    imageUrl: 'images/iphone.jpg',
  ),
  
  // coloca mais notícias aqui
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                backgroundColor: Color.fromARGB(105, 6, 5, 5),
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      )
                    );
                  },
                ),
                title: Row(
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    Image.asset('images/logo.png', height: 50),
                    Flexible(
                      child: Container(),
                      flex: 1,
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
                  )
                ],
                floating: false,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Noticia = NoticiaList[index];
                    return Card(
                      color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                Noticia.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              Noticia.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'ProductSansRegular',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: NoticiaList.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
