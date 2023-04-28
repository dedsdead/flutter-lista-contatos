import 'package:flutter/material.dart';

class FormContactFielder extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;
  final TextInputType textInputType;

  const FormContactFielder(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.controller,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hintText, filled: true, icon: Icon(iconData)),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Campo $hintText não pode ser vazio!';
        } else if (hintText == 'Nome' &&
            (!validateName(value) || value.length < 3)) {
          return 'Insira um nome válido!';
        } else if (hintText == 'Email' &&
            (!validateEmail(value) || value.length < 3)) {
          return 'Insira um e-mail válido!';
        }
        return null;
      },
    );
  }
}

validateName(String nome) {
  final reg = RegExp(r'(^\s*[A-Za-z]{3}[^\n\d]*$)');
  return reg.hasMatch(nome);
}

validateEmail(String email) {
  final reg = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return reg.hasMatch(email);
}
