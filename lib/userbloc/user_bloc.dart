import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocflutter/counter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final  StreamSubscription counterBlocSubscription;

  UserBloc(this.counterBloc) : super(UserState()) {
    on<UserGetUserEvent>(_onGetUser);
    on<UserGetUserJobEvent>(_onGetUserJob);
    counterBlocSubscription = counterBloc.stream.listen((state) {
      if(state <= 0) {
        add(UserGetUserEvent(0));
        add(UserGetUserJobEvent(0));
      }
    });
  }

  @override
  Future<void> close() async {
    counterBlocSubscription.cancel();
    return super.close();
  }

  _onGetUser(UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(event.count, (index) => User(name: "first_user", id: index.toString()));

    emit(state.copyWith(users: users));
  }

  _onGetUserJob(UserGetUserJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final job = List.generate(event.count, (index) => Job(jobTitle: "first_job", id: index.toString()));

    emit(state.copyWith(job: job));
  }
}
