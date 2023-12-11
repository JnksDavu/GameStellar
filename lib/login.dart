// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:gamestellar/register.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('E-mail de redefinição de senha enviado para $email');

      Fluttertoast.showToast(
        msg: "Email para alteração de senha enviado!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

    } on FirebaseAuthException catch (e) {
      print('Erro ao enviar e-mail de redefinição de senha: $e');

      Fluttertoast.showToast(
        msg: "Digite um e-mail válido!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Estrelas.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/Asteroids.gif',
                  height: 80,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.black,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 84, 58, 152)),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color:  Color.fromARGB(160, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.black,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 84, 58, 152)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color:  Color.fromARGB(160, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      Fluttertoast.showToast(
                          msg: "Bem Vindo!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(userEmail: _emailController.text,),
                        ),
                      );
                    } catch (e) {
                      print("Erro no login: $e");
                      Fluttertoast.showToast(
                          msg: "Email ou senha inválidos!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 73, 209),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text('Logar', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                    style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 28, 73, 209),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text('Cadastrar', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                                ElevatedButton(
                  onPressed: () {
                    resetPassword(_emailController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 129, 1, 164),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text('Esqueci minha senha', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),

              // Comentei tudo ai, se quiserem o cadastro com face, apple e google é só descomentar e fazer a lógica rsrs
              // const Text(
              //   'Cadastrar com',
              //   style: TextStyle(
              //     color: Colors.grey,
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              // const Divider(
              //   height: 1,
              //   thickness: 1,
              //   color: Color.fromARGB(255, 126, 49, 189),
              // ),
              // const SizedBox(height: 10),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Google login
              //   },
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(const Color.fromARGB(202, 244, 67, 54)),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //     ),
              //   ),
              //   icon: const Icon(Icons.email, size: 18),
              //   label: const Text('Google', style: TextStyle(fontSize: 14)),
              // ),
              // const SizedBox(height: 7),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Facebook login 
              //   },
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Color.fromARGB(204, 33, 89, 243)),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //     ),
              //   ),
              //   icon: const Icon(Icons.facebook, size: 18),
              //   label: const Text('Facebook', style: TextStyle(fontSize: 14)),
              // ),
              // const SizedBox(height: 7),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Apple ID login
              //   },
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 96, 94, 94)),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //     ),
              //   ),
              //   icon: const Icon(Icons.apple, size: 18),
              //   label: const Text('Apple ID', style: TextStyle(fontSize: 14)),
              // ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
