// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsersStore on _UsersStore, Store {
  late final _$listUserAtom =
      Atom(name: '_UsersStore.listUser', context: context);

  @override
  List<String> get listUser {
    _$listUserAtom.reportRead();
    return super.listUser;
  }

  @override
  set listUser(List<String> value) {
    _$listUserAtom.reportWrite(value, super.listUser, () {
      super.listUser = value;
    });
  }

  late final _$idUsersAtom =
      Atom(name: '_UsersStore.idUsers', context: context);

  @override
  Map<String, dynamic> get idUsers {
    _$idUsersAtom.reportRead();
    return super.idUsers;
  }

  @override
  set idUsers(Map<String, dynamic> value) {
    _$idUsersAtom.reportWrite(value, super.idUsers, () {
      super.idUsers = value;
    });
  }

  late final _$fetchUsersAsyncAction =
      AsyncAction('_UsersStore.fetchUsers', context: context);

  @override
  Future<void> fetchUsers() {
    return _$fetchUsersAsyncAction.run(() => super.fetchUsers());
  }

  @override
  String toString() {
    return '''
listUser: ${listUser},
idUsers: ${idUsers}
    ''';
  }
}
