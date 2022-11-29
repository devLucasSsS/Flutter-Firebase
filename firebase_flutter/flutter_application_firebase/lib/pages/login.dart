import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String errortext = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
            child: Column(
          children: [
            CampoEmail(),
            CampoPassword(),
            BotonLogin(),
          ],
        )),
      ),
    );
  }
}

class CampoEmail extends StatelessWidget {
  const CampoEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text('Email')),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class CampoPassword extends StatelessWidget {
  const CampoPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text('Password')),
      obscureText: true,
    );
  }
}

Widget BotonLogin() {
  return Container(
    margin: EdgeInsets.only(top: 20),
    width: double.infinity,
    child: ElevatedButton(
      child: Text('Iniciar Sesion'),
      onPressed: () async {
        UserCredential userCredential;
        try {
          userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailCtrl.text.trim(),
                  password: passwordCtrl.text.trim());
        } on FirebaseAuthException catch (ex) {
          switch (ex.code) {
            case 'user-not-found':
              errorText = 'usuario no encontrado';
              break;
            case 'wrong password':
              errorText = 'Contraseña incorrecta';
              break;
            default:
              errorText = 'Error desconocido';
              break;
          }
          setState(({}));
        }
      },
    ),
  );
}
