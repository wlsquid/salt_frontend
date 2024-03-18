import 'package:flutter/material.dart';
import 'package:salt/screens/address_lists.dart';
import 'package:salt/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login to salt'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("salt"),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Email',
                ),
                onSaved: (newValue) {
                  setState(() {
                    _email = newValue ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _emailTextEditingController,
              ),
              TextFormField(            
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'Password',
                ),
                onSaved: (newValue) {
                  setState(() {
                    _password = newValue ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: true,
                enableSuggestions: false,
                controller: _emailTextEditingController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing')),
                      );
                      final bool login = await AuthService().login(_email, _password);
                      if (login) {
                        
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const AddressListsScreen();
                        },));
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Failed')),
                      );
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}