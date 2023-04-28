import 'package:flutter/material.dart';
import 'package:formulario_contatos/common/box_user.dart';
import 'package:formulario_contatos/contact_list_view.dart';
import 'package:formulario_contatos/model/user.dart';

class SearchContact extends StatefulWidget {
  const SearchContact({super.key});

  @override
  State<SearchContact> createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContact> {
  @override
  Widget build(BuildContext context) {
    Map<int, UserModel> filteredUsers = {};

    final searchController = TextEditingController();

    searchController.addListener(() {
      Map<int, UserModel> users = UserBox.getUsersBox().values.toList().asMap();
      filteredUsers = Map.from(users)
        ..removeWhere((key, value) => ((searchController.text.isEmpty ||
            (!value.userId.contains(searchController.text) &&
                !value.userName.contains(searchController.text) &&
                !value.userEmail.contains(searchController.text)))));
    });

    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        const SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(bottom: 50.0),
            centerTitle: true,
            title: Text(
              'Pesquisar',
            ),
          ),
        ),
        SliverAppBar(
          title: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Pesquisar",
              suffixIcon: IconButton(
                alignment: Alignment.topCenter,
                onPressed: () => searchController.clear(),
                icon: const Icon(Icons.clear),
                color: Colors.black,
                splashRadius: 25,
              ),
            ),
            controller: searchController,
          ),
          leading: IconButton(
            padding: const EdgeInsets.only(bottom: 5),
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
          backgroundColor: Colors.white,
          pinned: true,
          elevation: 0.0,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ValueListenableBuilder(
                valueListenable: searchController,
                builder:
                    (BuildContext context, searchController, Widget? child) {
                  if (filteredUsers.isEmpty) {
                    return const Center(
                      heightFactor: 15,
                      child: Text(
                        'Nenhum resultado enontrado',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    return Center(
                      child: ContactListView(
                        users: filteredUsers,
                      ),
                    );
                  }
                },
              );
            },
            childCount: 1,
          ),
        )
      ]),
    );
  }
}
