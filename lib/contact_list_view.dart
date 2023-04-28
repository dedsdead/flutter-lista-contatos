import 'package:flutter/material.dart';
import 'package:formulario_contatos/common/box_user.dart';
import 'package:formulario_contatos/form_contact.dart';
import 'package:formulario_contatos/model/user.dart';
import 'package:formulario_contatos/routes/routes.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key, required this.users});

  final Map<int, UserModel> users;

  @override
  State<StatefulWidget> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  void _removeUser(int index) {
    setState(() {
      widget.users.remove(index);
    });
  }

  void _transformUser(int index, user) {
    if (user != null) {
      user as UserModel;
      setState(() {
        widget.users.update(index, (value) => user);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.0,
          child: ExpansionTile(
            title: Text(
                "${widget.users.values.elementAt(index).userId}: ${widget.users.values.elementAt(index).userName}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text(widget.users.values.elementAt(index).userEmail),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () async {
                        await Navigator.of(context)
                            .pushNamed(
                              Routes.form,
                              arguments: ScreenArguments(
                                widget.users.values.elementAt(index),
                                widget.users.keys.elementAt(index),
                              ),
                            )
                            .then(
                              (value) => _transformUser(
                                widget.users.keys.elementAt(index),
                                value,
                              ),
                            );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.amber.shade600,
                      ),
                      label: Text("Editar",
                          style: TextStyle(color: Colors.amber.shade600))),
                  TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Excluir Contato'),
                            content: Text(
                                'Tem certeza que deseja excluir o contato ${widget.users.values.elementAt(index).userName}?'),
                            actions: <Widget>[
                              SimpleDialogOption(
                                child: const Text('Não'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SimpleDialogOption(
                                child: const Text('Sim'),
                                onPressed: () {
                                  UserBox.getUsersBox().deleteAt(
                                      widget.users.keys.elementAt(index));
                                  _removeUser(index);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.pink,
                      ),
                      label: const Text("Excluir",
                          style: TextStyle(color: Colors.pink))),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
