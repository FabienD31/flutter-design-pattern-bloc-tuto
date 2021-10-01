import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  //State
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  //event
  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventState);
  }

  void _mapEventState(CounterEvent event) {
    event is IncrementEvent ? _counter++ : _counter--;
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
