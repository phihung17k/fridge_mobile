import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends dynamic> {
  late BehaviorSubject<T> _controller;

  BaseBloc(T state) {
    _controller = BehaviorSubject.seeded(state);
  }

  T get state => _controller.value;

  Sink<T> get _stateSink => _controller.sink;
  Stream<T> get stateStream => _controller.stream;

  void emit(T state) => _stateSink.add(state);

  @mustCallSuper
  void dispose() {
    _stateSink.close();
    _controller.close();
  }
}
