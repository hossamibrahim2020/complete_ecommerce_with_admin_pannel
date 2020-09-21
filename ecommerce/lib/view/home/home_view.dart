import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/customer.dart';
import '../../shared/widget/custom_button.dart';
import '../../shared/widget/custom_message_sender_field.dart';
import '../../shared/constants.dart';
import '../../shared/firebase_keys.dart';
import '../../view/detail/detail_view.dart';
import 'firebase_stream_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _store = FirebaseStreamViewmodel();
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
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        'Home',
        style: blueGrayTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.chat,
          color: Theme.of(context).primaryColor,
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

  Widget _body(BuildContext context) {
    return StreamBuilder(
      stream: _store.product(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Text('has no data');
        if (snapshot.hasData) {
          // return _bodyOfApp(snapshot, context);
          return _homeContent(snapshot, context);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  /// ReDesign of app
  Widget _homeContent(
    AsyncSnapshot<QuerySnapshot> snapshot,
    BuildContext context,
  ) {
    final List<QueryDocumentSnapshot> _listOfData = snapshot.data.docs;
    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: IntTween(begin: -120, end: 0),
      duration: Duration(seconds: 1),
      builder: (BuildContext context, int value, Widget child) {
        return Transform.translate(
          offset: Offset(value.toDouble(), 0),
          child: TweenAnimationBuilder(
            curve: Curves.ease,
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 3),
            builder: (BuildContext context, double valueOfOpacity, Widget child) {
              return Opacity(
                opacity: valueOfOpacity,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: _listOfData.map(
                    (e) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailView(e),
                              ),
                            );
                          },
                          child: GridTile(
                            footer: Container(
                              alignment: Alignment.bottomCenter,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.4),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${e.data()[name]}',
                                        style: titleStyle,
                                      ),
                                      Text(
                                        '${e.data()[price]} \$',
                                        style: titleStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            child: Hero(
                              tag: '${e.data()[name]}',
                              child: Center(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  imageUrl: '${e.data()[image]}',
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        );
      },
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

  /*SingleChildScrollView _bodyOfApp(
    AsyncSnapshot<QuerySnapshot> snapshot,
    BuildContext context,
  ) {
    final Size _size = MediaQuery.of(context).size;
    final List<QueryDocumentSnapshot> _listOfData = snapshot.data.docs;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          // header
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _listOfData.map(
                (e) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: _size.height * .32,
                      width: _size.height * .275,
                      child: _singleItem(e, context),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          // body
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: _listOfData.map(
                (e) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: _size.height * .3,
                      width: double.infinity,
                      child: _singleItem(e, context),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          // bottom
          _sindeMessageToUs(context),
        ],
      ),
    );
  }*/

  /*Widget _singleItem(QueryDocumentSnapshot e, BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailView(e),
            ),
          );
        },
        child: Card(
          child: Stack(
            children: <Widget>[
              Hero(
                tag: '${e.data()[name]}',
                child: Center(
                  child: Image.network(
                    e.data()[image],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: _size.height * .06,
                    color: Theme.of(context).primaryColor.withOpacity(.4),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${e.data()[name]}',
                              style: titleStyle,
                            ),
                            Text(
                              '${e.data()[price]} \$',
                              style: titleStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          elevation: 2.0,
        ),
      ),
    );
  }

  Widget _sindeMessageToUs(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 40,
        ),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              CustomMessageSenderField(
                hint: 'Message',
                controller: null,
                icon: Icon(Icons.message),
                textFieldColor: Colors.white,
                textInputType: TextInputType.text,
              ),
              CustomMessageSenderField(
                hint: 'Your email',
                controller: null,
                icon: Icon(Icons.email),
                textFieldColor: Colors.white,
                textInputType: TextInputType.emailAddress,
              ),
              CustomRadiusButton(
                onpress: () {
                  if (_key.currentState.validate()) {
                    _customer.send(
                      _emailController.text,
                      _messageController.text,
                      context,
                    );
                    _emailController.clear();
                    _messageController.clear();
                  }
                },
                label: 'Send Message',
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
