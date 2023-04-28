import 'package:flutter/material.dart';
import 'package:formulario_contatos/common/box_user.dart';
import 'package:formulario_contatos/form_contact_fielder.dart';
import 'package:formulario_contatos/model/user.dart';

//TODO: Arrumar o visual do form!

class ScreenArguments {
  final UserModel user;
  final int position;

  ScreenArguments(this.user, this.position);
}

class FormContact extends StatelessWidget {
  FormContact({super.key});

  final idUserControl = TextEditingController();
  final nameUserControl = TextEditingController();
  final emailUserControl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FormContactFielder formContact(
      TextEditingController controller, IconData icon, String text) {
    return FormContactFielder(
      hintText: text,
      iconData: icon,
      controller: controller,
    );
  }

  void _clearTextControllers() {
    idUserControl.clear();
    nameUserControl.clear();
    emailUserControl.clear();
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var args;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
      UserModel user = args.user;
      idUserControl.text = user.userId;
      nameUserControl.text = user.userName;
      emailUserControl.text = user.userEmail;
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 25,
            color: Colors.black,
            splashRadius: 25,
            alignment: Alignment.center,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: const Text(
            "Lista de Contatos",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              formContact(idUserControl, Icons.person, "Codigo"),
              formContact(nameUserControl, Icons.person_outline, "Nome"),
              formContact(emailUserControl, Icons.email_outlined, "Email"),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _clearTextControllers();
                            _formKey.currentState?.save();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final isValid = _formKey.currentState?.validate();

                            UserModel user = UserModel()
                              ..userId = idUserControl.text
                              ..userName = nameUserControl.text
                              ..userEmail = emailUserControl.text;

                            if (isValid != null && isValid) {
                              _formKey.currentState?.save();
                              if (ModalRoute.of(context)!.settings.arguments !=
                                  null) {
                                UserBox.getUsersBox()
                                    .putAt(args.position, user);
                                Navigator.of(context).pop(user);
                              } else {
                                UserBox.getUsersBox().add(user);
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: const Text(
                            "Salvar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
