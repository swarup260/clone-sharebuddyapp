import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final Widget child;

  LoginScreen({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ShareBuddy'.toUpperCase(),
                style: TextStyle(fontSize: 18.0),
              ),
              Icon(
                FontAwesomeIcons.car,
                size: 100,
              ),
              RegisterForm(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('---------------------OR---------------------'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.facebook,
                    size: 50.0,
                  ),
                  Icon(
                    FontAwesomeIcons.google,
                    size: 50.0,
                  ),
                  Icon(
                    FontAwesomeIcons.twitter,
                    size: 50.0,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  /* form key */
  final _formKey = GlobalKey<FormState>();
  String userName, password;
  @override
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FormField(
              userValidator, saveUser, userName, 'Email', Icon(Icons.person)),
          FormField(userValidator, savePass, password, 'Password',
              Icon(Icons.phonelink_lock)),
          // Align(
          //   child: Padding(
          //     child: Text(
          //       'Forgot Password ?',
          //     ),
          //     padding: EdgeInsets.symmetric(horizontal: 10.0),
          //   ),
          //   alignment: Alignment.topRight,
          // ),
          FlatButton(
            child: Text('Submit'),
            color: Theme.of(context).primaryColor,
            onPressed: formSubmit,
          ),
        ],
      ),
    );
  }

  String userValidator(String value) {
    if (value.isEmpty) {
      return 'Please Enter UserName';
    }
  }

  formSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Data Submited'),
      ));
    }
  }

  saveUser(String value) {
    userName = value;
    // setState(() {
    // });
  }

  savePass(String value) {
    password = value;
    // setState(() {
    // });
  }
}

class FormField extends StatelessWidget {
  Function validatorMethod, saveData;
  String inputValue, hintText;
  Widget icon;
  FormField(this.validatorMethod, this.saveData, this.inputValue, this.hintText,
      this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        validator: validatorMethod,
        onSaved: saveData,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // hintText: hintText
        ),
      ),
    );
  }
}
