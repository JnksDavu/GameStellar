import 'package:flutter/material.dart';
import 'package:gamestellar/register.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _rememberMe = false;

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
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/Asteroids.gif',
                height: 80,
              ),
              const SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Usuário',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 84, 58, 152)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autofocus: true,
                obscureText: !_showPassword,
                keyboardType: TextInputType.name,
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
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Switch(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                    activeColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HomePage(),
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 28, 73, 209)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text('Logar', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const RegisterPage(),
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 88, 23, 141)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text('Cadastrar', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 50),
              const Text(
                'Cadastrar com',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color.fromARGB(255, 126, 49, 189),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Google login logic
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(202, 244, 67, 54)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                icon: const Icon(Icons.email, size: 18),
                label: const Text('Google', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 7),
              ElevatedButton.icon(
                onPressed: () {
                  // Facebook login logic
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(204, 33, 89, 243)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                icon: const Icon(Icons.facebook, size: 18),
                label: const Text('Facebook', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 7),
              ElevatedButton.icon(
                onPressed: () {
                  // Apple ID login logic
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 96, 94, 94)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                icon: const Icon(Icons.apple, size: 18),
                label: const Text('Apple ID', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
