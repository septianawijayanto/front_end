import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtUsername = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: txtUsername,
                    decoration: InputDecoration(hintText: "Masukkan Username"),
                  ),
                  TextFormField(
                    controller: txtPassword,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Masukkan Email"),
                  ),
                  ButtonTheme(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                    onPressed: () {
                      this._doLogin();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Atau"),
                  ButtonTheme(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context,  MaterialPageRoute(builder: con));
                    },
                    child: Text(
                      "Registrasi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            )
          ],
        ));
  }

  Future _doLogin() async {
    if (txtUsername.text.isEmpty || txtPassword.text.isEmpty) {
      Alert(context: context, title: "Data Tidak Benar", type: AlertType.error)
          .show();
      return;
    }
    ProgressDialog progressDialog = ProgressDialog(context);
    progressDialog.style(message: "Loading...");
    progressDialog.show();
    final response =
        await http.post(Uri.parse('http://127.0.0.1:8000/api/login'), body: {
      'email': txtUsername.text,
      'password': txtPassword.text,
    }, headers: {
      'Accept': 'application/json',
    });
    progressDialog.hide();
    if (response.statusCode == 200) {
      Alert(context: context, title: "Login Berhasil", type: AlertType.success)
          .show();
    } else {
      Alert(context: context, title: "Login Gagal", type: AlertType.error)
          .show();
    }
  }
}
