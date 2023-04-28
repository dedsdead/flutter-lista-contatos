import 'package:flutter/material.dart';
import 'package:formulario_contatos/common/box_user.dart';
import 'package:formulario_contatos/contact_list_view.dart';
import 'package:formulario_contatos/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeContact extends StatefulWidget {
  const HomeContact({super.key});

  @override
  State<HomeContact> createState() => _HomeContactState();
}

class _HomeContactState extends State<HomeContact> {
  final box = UserBox.getUsersBox().listenable();

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 50.0),
              centerTitle: true,
              title: Text(
                'Contatos',
              ),
            ),
          ),
          SliverAppBar(
            elevation: 0,
            actions: <Widget>[
              IconButton(
                splashRadius: 25,
                color: Colors.black,
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.form);
                },
              ),
              IconButton(
                splashRadius: 25,
                color: Colors.black,
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.search);
                },
              ),
            ],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ValueListenableBuilder(
                  valueListenable: box,
                  builder: (BuildContext context, Box userBox, Widget? child) {
                    final users = box.value.values.toList().asMap();
                    if (users.isEmpty) {
                      return const Center(
                          heightFactor: 15,
                          child: Text('Nenhum contato adicionado',
                              style: TextStyle(color: Colors.black)));
                    } else {
                      return Center(
                        child: ContactListView(
                          users: users,
                        ),
                      );
                    }
                  },
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
