import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends dynamic> {
  late BehaviorSubject<T> _controller;
  late BehaviorSubject<bool> _loadingController;

  BaseBloc(T state) {
    _controller = BehaviorSubject.seeded(state);
    _loadingController = BehaviorSubject.seeded(false);
  }

  T get state => _controller.value;

  Sink<T> get _stateSink => _controller.sink;
  Stream<T> get stateStream => _controller.stream;

  Sink<bool> get _loadingSink => _loadingController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;

  void emit(T state) => _stateSink.add(state);

  void load(bool value) => _loadingSink.add(value);

  @mustCallSuper
  void dispose() {
    _stateSink.close();
    _loadingSink.close();

    _controller.close();
    _loadingController.close();
  }
}
