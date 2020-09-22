import '../../models/customer.dart';
import '../../models/is_loding_provider.dart';
import '../shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../shared/widget/custom_button.dart';
import '../shared/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUPView extends StatefulWidget {
  @override
  _SignUPViewState createState() => _SignUPViewState();
}

class _SignUPViewState extends State<SignUPView> {
  final Customer _customer = Customer();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final String _label = 'Sign Up';
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
              title: Text(
                _label,
                style: tealTextStyle,
              ),
            ),
      body: _isLoding.isLoding
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .22,
                    ),
                    CustomTextField(
                      'name',
                      Icons.person,
                      null,
                      TextInputType.text,
                      false,
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
                              await _customer.regester(
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
