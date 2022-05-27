import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_market_shop_app/helpers/style.dart';
import 'package:in_market_shop_app/widgets/custom_text_form_field.dart';
import 'package:in_market_shop_app/widgets/login_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            decoration: loginDecoration,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 320),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const LoginTitle(),
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      const Text(
                        '既に登録済みの方はログインしてください',
                        style: loginMessageStyle,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'メールアドレス',
                        iconData: Icons.email,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
