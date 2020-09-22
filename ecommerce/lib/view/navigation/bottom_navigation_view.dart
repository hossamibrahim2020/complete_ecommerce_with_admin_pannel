import '../explore/explore_view.dart';
import '../../models/is_loding_provider.dart';
import 'package:provider/provider.dart';
import '../../models/customer.dart';
import '../shared/constants.dart';
import '../shared/widget/custom_button.dart';
import '../shared/widget/custom_message_sender_field.dart';
import '../shared/theme.dart';
import '../../view/home/home_view.dart';
import '../../view/cart/cart_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationView extends StatefulWidget {
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _currentIndex = 0;
  final List<Widget> _screen = [
    HomeView(),
    ExploreView(),
    CartView(),
  ];
  final List<String> _title = [
    'home',
    'explore',
    'cart',
  ];

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final Customer _customer = Customer();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoding = Provider.of<IsLoding>(context);
    return Scaffold(
      // TODO: add search for
      appBar: _isLoding.isLoding ? null : _appBar(context),
      body: _isLoding.isLoding
          ? Center(child: CircularProgressIndicator())
          : _screen.elementAt(_currentIndex),
      bottomNavigationBar: _isLoding.isLoding ? null : _bottomNavigationBar(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        _title.elementAt(_currentIndex),
        style: whiteTextStyle.copyWith(fontSize: 25),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
          ),
          onPressed: () {
            _customer.signOut(context);
          },
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.chat,
        ),
        onPressed: () {
          _openDialogeToSendMessage(context, () {
            if (_key.currentState.validate()) {
              _customer.send(
                _emailController.text,
                _messageController.text,
                context,
              );
              _emailController.clear();
              _messageController.clear();
              Navigator.of(context).pop();
            }
          });
        },
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedItemColor: unSelectexItemColor,
      unselectedItemColor: Colors.blueGrey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          title: Text('Explore'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cart'),
        ),
      ],
    );
  }

  Future<void> _openDialogeToSendMessage(
      BuildContext context, Function send) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // privent user tap
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Send Feed Back'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          // backgroundColor: Colors.black,
          content: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomMessageSenderField(
                    hint: 'Message',
                    controller: _messageController,
                    icon: Icon(Icons.message),
                    textFieldColor: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                  CustomMessageSenderField(
                    hint: 'Your email',
                    controller: _emailController,
                    icon: Icon(Icons.email),
                    textFieldColor: Colors.white,
                    textInputType: TextInputType.emailAddress,
                  ),
                  CustomRadiusButton(
                    onpress: () {
                      send();
                    },
                    label: 'Send Message',
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
