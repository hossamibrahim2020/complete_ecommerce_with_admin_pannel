import '../view/home/send_message_viewmodel.dart';
import '../view/signin/i_can_sign_in_viewmodel.dart';
import '../view/signup/i_can_signup_viewmodel.dart';
import 'base_user.dart';

class Customer extends BaseUser
    with ICanSignIn, ICanSignUP, SendMessageViewmodel {}
