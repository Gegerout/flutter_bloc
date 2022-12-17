part of 'user_bloc.dart';

class UserState {
  final List<User> users;
  final List<Job> jobs;
  final bool isLoading;

  UserState({this.users = const[], this.jobs = const[], this.isLoading = false});

  UserState copyWith({List<User>? users, List<Job>? job, bool isLoading = false}) {
    return UserState(
      users: users ?? this.users,
      jobs: job ?? jobs,
      isLoading: isLoading
    );
  }
}

// class UserInitial extends UserState {}
//
// class UserLoadState extends UserState {
//   final List<User> users;
//
//   UserLoadState(this.users);
// }
//
// class UserLoadingstate extends UserState {}

class User {
  final String name;
  final String id;

  User({required this.name, required this.id});
}

class Job {
  final String jobTitle;
  final String id;

  Job({required this.jobTitle, required this.id});
}
