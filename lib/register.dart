import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
              const SizedBox(height: 30),
              _buildInputField('Email', _emailController, Icons.mail),
              const SizedBox(height: 10),
              _buildInputField(
                  'Confirmar Email', _confirmEmailController, Icons.mail),
              const SizedBox(height: 10),
              _buildPasswordField('Senha', _passwordController),
              const SizedBox(height: 10),
              _buildPasswordField(
                  'Confirmar Senha', _confirmPasswordController),
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

  Widget _buildInputField(
      String hintText, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
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

  Widget _buildPasswordField(String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
      onPressed: () async {
        try {
          // ignore: unused_local_variable
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

          // Se o registro for bem-sucedido, navegue para a tela principal
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } catch (e) {
          // Handle errors, como exibição de uma mensagem de erro
          print("Erro no registro: $e");
        }
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
