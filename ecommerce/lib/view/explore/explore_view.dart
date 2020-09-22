import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../detail/detail_view.dart';
import '../home/firebase_stream_viewmodel.dart';
import '../shared/constants.dart';
import '../shared/firebase_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return _body(context);

    final _store = Provider.of<FirebaseStreamViewmodel>(context);
    return TweenAnimationBuilder(
      curve: Curves.ease,
      duration: Duration(seconds: 1),
      tween: IntTween(begin: 120, end: 0),
      builder: (BuildContext context, int value, Widget child) {
        return Transform.translate(
          offset: Offset(0, value.toDouble()),
          child: TweenAnimationBuilder(
            curve: Curves.ease,
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 2),
            builder: (BuildContext context, double opacityValue, Widget child) {
              return Opacity(
                opacity: opacityValue,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _store.product(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasData) {
                      return _body(context, snapshot);
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return CustomScrollView(
      slivers: snapshot.data.docs.map(
        (e) {
          return SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailView(e),
                  ),
                );
              },
              child: Card(
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${e.data()[name]}',
                            style: titleStyle.copyWith(color: Colors.black),
                          ),
                          Text(
                            '${e.data()[price]} \$',
                            style: titleStyle.copyWith(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  background: Hero(
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
            ),
          );
        },
      ).toList(),
    );
  }
}
