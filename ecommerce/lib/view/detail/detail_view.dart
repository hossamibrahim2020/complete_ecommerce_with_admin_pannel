import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/constants.dart';
import '../../shared/firebase_keys.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final QueryDocumentSnapshot e;

  const DetailView(this.e);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          expandedHeight: _size.height * .5,
          flexibleSpace: FlexibleSpaceBar(
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
            title: Text(
              '${e.data()[name]}',
              style: blueGrayTextStyle.copyWith(color: Colors.black),
            ),
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // TODO: add content
            ],
          ),
        ),
      ],
    );
  }
}
