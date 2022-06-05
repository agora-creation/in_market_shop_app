import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/services/shop.dart';

enum Status { authenticated, uninitialized, authenticating, unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.uninitialized;
  Status get status => _status;
  FirebaseAuth? auth;
  User? _fUser;
  ShopService shopService = ShopService();
  ShopModel? _shop;
  ShopModel? get shop => _shop;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void clearController() {
    emailController.text = '';
    passwordController.text = '';
    rePasswordController.text = '';
    nameController.text = '';
  }

  AuthProvider.initialize() : auth = FirebaseAuth.instance {
    auth?.authStateChanges().listen(_onStateChanged);
  }

  Future<String?> login() async {
    String? errorText;
    if (emailController.text.isEmpty) errorText = 'メールアドレスを入力してください。';
    if (passwordController.text.isEmpty) errorText = 'パスワードを入力してください。';
    try {
      _status = Status.authenticating;
      notifyListeners();
      await auth
          ?.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        _shop = await shopService.select(id: value.user?.uid);
        if (_shop == null) {
          await auth?.signOut();
          return false;
        }
      });
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      errorText = 'ログインに失敗しました。';
    }
    return errorText;
  }

  Future<String?> regist() async {
    String? errorText;
    if (emailController.text.isEmpty) errorText = 'メールアドレスを入力してください。';
    if (passwordController.text.isEmpty) errorText = 'パスワードを入力してください。';
    if (passwordController.text != rePasswordController.text) {
      errorText = 'パスワードをご確認ください。';
    }
    if (nameController.text.isEmpty) errorText = 'お名前を入力してください。';
    try {
      _status = Status.authenticating;
      notifyListeners();
      await auth
          ?.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        shopService.create({
          'id': value.user?.uid,
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'name': nameController.text.trim(),
          'priceView': false,
          'token': '',
          'createdAt': DateTime.now(),
        });
      });
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      errorText = '登録に失敗しました。';
    }
    return errorText;
  }

  Future logout() async {
    await auth?.signOut();
    _status = Status.unauthenticated;
    _shop = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future reloadUser() async {
    _shop = await shopService.select(id: _fUser?.uid);
    notifyListeners();
  }

  Future _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _fUser = firebaseUser;
      _status = Status.authenticated;
      _shop = await shopService.select(id: _fUser?.uid);
    }
    notifyListeners();
  }
}
