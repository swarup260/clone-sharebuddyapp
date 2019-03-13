import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final Widget child;
  IconData icon1 = FontAwesomeIcons.facebook;
  IconData icon2 = FontAwesomeIcons.googlePlus;
  Color color1 = Colors.blueAccent;
  Color color2 = Colors.red;
  String text1 = 'Facebook';
  String text2 = 'Google';

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
                style: TextStyle(fontSize: 15.0),
              ),
              Icon(
                FontAwesomeIcons.car,
                size: 80,
              ),
              RegisterForm(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '----------------- OR SIGN UP WITH -----------------',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SocialIconButton(text: text1, icon: icon1, color: color1),
                  new SocialIconButton(text: text2, icon: icon2, color: color2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: Colors.white, wordSpacing: 3),
          ),
          Icon(
            icon,
            size: 30.0,
          )
        ],
      ),
      color: color,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTheme(
                height: 40.0,
                minWidth: 160.0,
                child: RaisedButton(
                  child: Text('Login'),
                  color: Theme.of(context).primaryColor,
                  onPressed: formSubmit,
                ),
              ),
              ButtonTheme(
                height: 40.0,
                minWidth: 160.0,
                child: RaisedButton(
                  child: Text('Register'),
                  color: Theme.of(context).primaryColor,
                  onPressed: formSubmit,
                ),
              )
            ],
          )
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextFormField(
        validator: validatorMethod,
        onSaved: saveData,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          labelText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          // hintText: hintText
        ),
      ),
    );
  }
}
