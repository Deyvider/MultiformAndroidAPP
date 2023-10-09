import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Aplica un tema oscuro en toda la aplicación
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multiformularios'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://www.pngmart.com/files/23/Lock-PNG-Transparent.png',
                height: 300,
                width: 300,
              ),
              FormularioUno(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioUno extends StatefulWidget {
  @override
  _FormularioUnoState createState() => _FormularioUnoState();
}

class _FormularioUnoState extends State<FormularioUno> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _loginFocusNode = FocusNode();

  @override
  void dispose() {
    _loginFocusNode.dispose();
    super.dispose();
  }

  void _resetFocus() {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_loginFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _loginController,
            focusNode: _loginFocusNode,
            decoration: InputDecoration(
              labelText: 'Login',
              labelStyle: TextStyle(fontSize: 20),
            ),
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 20),
            ),
            style: TextStyle(fontSize: 24),
            obscureText: true,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String login = _loginController.text;
            String password = _passwordController.text;
            bool isAuthorized = _authorizeUser(login, password);

            if (isAuthorized) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormularioDos(
                    login: login,
                    password: password,
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Usuario No Autorizado',
                      style: TextStyle(fontSize: 20),
                    ),
                    content: Text(
                      'Usuario o contraseña incorrectos.',
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _loginController.clear();
                          _passwordController.clear();
                          _resetFocus();
                        },
                        child: Text('Aceptar', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  );
                },
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Validar Usuario',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Salir',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }

  bool _authorizeUser(String login, String password) {
    return login == 'usuario' && password == '12345';
  }
}

class FormularioDos extends StatelessWidget {
  final String login;
  final String password;

  FormularioDos({required this.login, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Formulario 2',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 20),
            AlertDialog(
              title: Text('Usuario Autorizado', style: TextStyle(fontSize: 24)),
              content: Column(
                children: <Widget>[
                  Text('Login: $login', style: TextStyle(fontSize: 20)),
                  Text('Password: $password', style: TextStyle(fontSize: 20)),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar', style: TextStyle(fontSize: 22)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}