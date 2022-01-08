part of 'extensions.dart';

extension FirebaseUserExtension on auth.User {
  User convertToUser({String name = "No Name"}) =>
      User(this.uid, this.email, name: name);

  Future<User> fromFireStore() async => UserServices.getUser(this.uid);
}
