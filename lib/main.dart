import 'package:blocflutter/counter_bloc.dart';
import 'package:blocflutter/userbloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();

    return MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(create: (context) => counterBloc),
          BlocProvider<UserBloc>(create: (context) => UserBloc(counterBloc))
        ],
        child:
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();

    return Builder(
      builder: (context) {
        return Scaffold(
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      final counterBloc = context.read<CounterBloc>();
                      counterBloc.add(CounterIncEvent());
                    },
                    icon: const Icon(Icons.plus_one)),
                IconButton(
                    onPressed: () {
                      final counterBloc = context.read<CounterBloc>();
                      counterBloc.add(CounterDecEvent());
                    },
                    icon: const Icon(Icons.exposure_minus_1)),
                IconButton(
                    onPressed: () {
                      final userBloc = context.read<UserBloc>();
                      userBloc.add(UserGetUserEvent(context.read<CounterBloc>().state));
                    },
                    icon: const Icon(Icons.person)),
                IconButton(
                    onPressed: () {
                      final userBloc = context.read<UserBloc>();
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                          BlocProvider.value(value: userBloc,child: const Job(),)
                      ));
                      userBloc.add(UserGetUserJobEvent(context.read<CounterBloc>().state));
                    },
                    icon: const Icon(Icons.work))
              ],
            ),
            body: SafeArea(
              child: Center(
                  child: Column(
                children: [
                  BlocBuilder<CounterBloc, int>(
                    //bloc: counterBloc,
                    builder: (context, state) {
                      final users = context.select((UserBloc bloc) => bloc.state.users);
                      return Column(
                        children: [
                          Text(
                            state.toString(),
                            style: const TextStyle(fontSize: 30),
                          ),

                          if(users.isNotEmpty)
                            ...users.map((e) => Text(e.name))
                        ],
                      );
                    },
                  ),
                ],
              )
              ),
            )
        );
      }
    );
  }
}

class Job extends StatelessWidget {
  const Job({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
          //bloc: userBloc,
          builder: (context, state) {
            final users = state.users;
            final jobs = state.jobs;

            return Column(
              children: [
                if (users.isEmpty && state.isLoading)
                  const CircularProgressIndicator(),
                // if (users.isNotEmpty)
                //   ...state.users.map(
                //     (e) => Text(
                //       e.name,
                //       style: const TextStyle(fontSize: 30),
                //     ),
                //   ),
                if (jobs.isNotEmpty)
                  ...state.jobs.map(
                        (e) => Text(
                      e.jobTitle,
                    ),
                  )
              ],
            );
          },
        ),
    );
  }
}

