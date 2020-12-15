import 'package:flutter/material.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

// TODO: ReactiveForm
class _LoginViewState extends State<LoginView> {
  bool loading = false;

  final AuthService _auth = AuthService();

  final form = fb.group({
    'email': [Validators.required, Validators.email],
    'password': [Validators.required],
  });

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
            child: ReactiveForm(
              formGroup: form,
              child: loading
                  ? CircularProgressIndicator()
                  : Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      ReactiveTextField(
                        formControlName: 'email',
                        autofocus: true,
                        decoration: InputDecoration(labelText: 'E-mail'),
                        textInputAction: TextInputAction.next,
                        onSubmitted: () => form.focus('password'),
                        validationMessages: (control) => {
                          'required': 'The email must not be empty',
                          'email': 'The email value must be a valid email'
                        }
                      ),
                      ReactiveTextField(
                        formControlName: 'password',
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        textInputAction: TextInputAction.done,
                        onSubmitted: login,
                        validationMessages: (control) => {
                          'required': 'The password must not be empty',
                        },
                      ),
                      error != null ? Text(error) : SizedBox(),
                      SubmitButton(login),
                    ]),
            ),
          ),
        )));
  }

  login() async {
    if (!form.valid) return;
    setState(() {
      error = null;
      loading = true;
    });

    dynamic result = await _auth.signIn(form.value['email'], form.value['password']);

    if (result == null) {
      setState(() {
        error = 'Can\'t login';
        loading = false;
      });
    }
  }
}

class SubmitButton extends StatelessWidget {
  final onPress;

  SubmitButton(this.onPress);

  @override
  Widget build(BuildContext context) {
    final valid = ReactiveForm.of(context).valid;

    return RaisedButton(
      child: Text('Login'),
      onPressed: valid ? onPress : null,
    );
  }
}
