//import 'dart:js_interop';
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gamestellar/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Estrelas.gif'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Cadastro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _buildInputField('Email', Icons.mail),
              const SizedBox(
                height: 10,
              ),
              _buildInputField('Confirmar Email', Icons.mail),
              const SizedBox(
                height: 10,
              ),
              _buildPasswordField('Senha'),
              const SizedBox(
                height: 10,
              ),
              _buildPasswordField('Confirmar Senha'),
              const SizedBox(height: 30),
              _buildElevatedButton('Cadastrar'),
              const SizedBox(height: 10),
              _buildLoginTextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, IconData icon) {
    return TextFormField(
      autofocus: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 103, 49, 178)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hintText) {
    return TextFormField(
      autofocus: true,
      obscureText: !_showPassword,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.grey,
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
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 103, 49, 178)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Coloque a função de autenticação aqui

        // Navega para a tela de login quando o botão "Cadastrar" é pressionado
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 103, 49, 178)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildLoginTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      child: Text(
        "Se já possui uma conta, faça login.",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}