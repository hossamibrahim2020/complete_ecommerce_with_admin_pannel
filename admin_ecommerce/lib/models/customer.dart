import 'ican_regester.dart';
import 'ican_sigin.dart';
import 'ican_sigout.dart';
import 'base_user.dart';

class Customer extends BaseUser implements ICanRegester,ICanSigin,ICanSigout
{
  @override
  void regester() 
  {}

  @override
  void sigin() 
  {}

  @override
  void sigout() 
  {}
}