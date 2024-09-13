import 'package:ccv_manager/library_widget/providers/current_user_provider.dart';
import 'package:ccv_manager/models/library_models/library_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../library_widget/providers/library_user_provider.dart';

class SearchInput extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final TextEditingController _textEditingController = TextEditingController();

  List<String> _userList = [];
  List<LibraryUser> allUsers = [];
  List<String> _suggestedUsers = [];

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
    _getUsers();
  }

  _getUsers() async {
    await ref.read(libraryUserProvider.notifier).getUsers();
    allUsers = ref.read(libraryUserProvider);
    _userList = allUsers.map((u) => u.name).toList();
    return _userList;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    String query = _textEditingController.text.toLowerCase();
    List<String> suggestedUsers = [];

    if (query.isNotEmpty) {
      suggestedUsers = _userList.where((user) {
        return user.toLowerCase().contains(query);
      }).toList();
    }

    setState(() {
      _suggestedUsers = suggestedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: _textEditingController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Pesquisar usuário',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(15),
              child: const Icon(
                Icons.search,
                color: Colors.teal,
                size: 20,
              ),
            ),
          ],
        ),
        if (_suggestedUsers.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestedUsers.length,
              itemBuilder: (context, index) {
                String user = _suggestedUsers[index];
                return ListTile(
                  title: Text(user),
                  onTap: () {
                    _selectUser(user);
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  void _selectUser(String user) {
    LibraryUser? current = allUsers.firstWhere((u) => u.name == user);
    ref.read(currentLibraryUserProvider.notifier).update((state) => current);
    _textEditingController.clear();
    // setState(() {});
  }
}
