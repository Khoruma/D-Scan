import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tugas_akhir/models/models.dart';
import 'package:tugas_akhir/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      User updatedUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profilePicture);

      await UserServices.updateUser(updatedUser);
    }
  }
}
