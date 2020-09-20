import 'package:ecommerce/models/customer.dart';
import 'package:ecommerce/models/is_loding_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../shared/widget/custom_button.dart';
import '../../shared/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final Customer _customer = Customer();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final String _label = 'Sign In';
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoding = Provider.of<IsLoding>(context);
    return Scaffold(
      appBar: _isLoding.isLoding
          ? null
          : AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
              title: Text(_label),
            ),
      body: _isLoding.isLoding
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
                    ),
                    CustomTextField(
                      'Email',
                      Icons.email,
                      _emailController,
                      TextInputType.emailAddress,
                      false,
                    ),
                    CustomTextField(
                      'Password',
                      Icons.lock_open,
                      _passwordController,
                      TextInputType.number,
                      true,
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return CustomRadiusButton(
                          onpress: () async {
                            if (_key.currentState.validate()) {
                              await _customer.signin(
                                _emailController.text,
                                _passwordController.text,
                                context,
                                _isLoding,
                              );
                            }
                          },
                          label: _label,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
