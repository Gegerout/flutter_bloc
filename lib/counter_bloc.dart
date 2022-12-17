import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(): super(1) {
    on<CounterIncEvent>(_onIncrement);
    on<CounterDecEvent>(_onDecrement);
  }

  _onIncrement(CounterIncEvent event, Emitter<int> int) {
    if (state > 10) return;
    emit(state + 1);
  }

  _onDecrement(CounterDecEvent event, Emitter<int> int) {
    if (state < 1) return;
    emit(state - 1);
  }
}

abstract class CounterEvent {}

class CounterIncEvent extends CounterEvent {}
class CounterDecEvent extends CounterEvent {}