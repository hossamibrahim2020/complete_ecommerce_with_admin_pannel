import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:adminecommerce/models/admin.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import '../../shared/theme.dart';
import '../../shared/custom_text_field.dart';
import 'add_src.dart';
import 'package:flutter/material.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import '../../shared/custom_button.dart';

class AddView extends StatefulWidget {
  static const id = '/add';
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final AddSrc _addSrc = AddSrc();
  final Admin _admin = Admin();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  bool isLoding = false;
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_addSrc.title),
      ),
      drawer: ReusableDrawerView(),
      body: isLoding == true
          ? Center(child: CircularProgressIndicator())
          : _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              _addSrc.name,
              Icons.text_fields,
              _nameController,
              TextInputType.text,
            ),
            CustomTextField(
              _addSrc.description,
              Icons.description,
              _descriptionController,
              TextInputType.text,
            ),
            CustomTextField(
              _addSrc.price,
              Icons.monetization_on,
              _priceController,
              TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              _addSrc.tax,
              Icons.attach_money,
              _taxController,
              TextInputType.numberWithOptions(),
            ),
            // Image
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Container(
                height: _size.height * .3,
                width: _size.height * .2,
                decoration: BoxDecoration(
                  color: imageColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: _image == null
                    ? IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 40,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {
                          getImageFromGallary();
                        },
                      )
                    : Center(
                      child: GestureDetector(
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          getImageFromGallary();
                        },
                      ),
                    ),
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return CustomButton(
                  _addSrc.title,
                  () {
                    _addProduct();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Image Picker
  File _image;
  final ImagePicker _picker = ImagePicker();
  String _storeUrl;
  static const String storageBucket = 'gs://flutter-shop-complete.appspot.com';

  getImageFromGallary() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  upLoadImageToFirebase() async {
    try {
      FirebaseStorage _storage = FirebaseStorage(storageBucket: storageBucket);
      StorageReference _ref = _storage.ref().child(path.basename(_image.path));
      StorageUploadTask _storageUploadTask = _ref.putFile(_image);
      StorageTaskSnapshot _taskSnapshot = await _storageUploadTask.onComplete;
      String _getUrl = await _taskSnapshot.ref.getDownloadURL();
      setState(() {
        _storeUrl = _getUrl;
        print('URL        $_storeUrl');
      });
    } on PlatformException catch (e) {
      Toast.show('${e.message}', context);
    }
  }

  Future<void> _addProduct() async {
    if (_key.currentState.validate() && _image != null) {
      setState(() {
        isLoding = true;
      });
      await upLoadImageToFirebase();
      _admin.addProduct(
        context,
        _nameController.text,
        _priceController.text,
        _descriptionController.text,
        _taxController.text,
        _storeUrl,
      );
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _taxController.clear();
      setState(() {
        _image = null;
        isLoding = false;
      });
    }
  }
}
