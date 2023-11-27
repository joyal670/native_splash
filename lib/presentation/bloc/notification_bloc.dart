import 'package:alot/domain/api.dart';
import 'package:alot/presentation/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* --------------------------------------------------------------------------------------  */
// state
class NotificationBlocState {
  bool isLoading;
  List<NotificationModel> data;
  bool isError;

  NotificationBlocState({
    required this.isLoading,
    required this.data,
    required this.isError,
  });

  factory NotificationBlocState.initial() =>
      NotificationBlocState(data: [], isError: false, isLoading: true);
}

/* --------------------------------------------------------------------------------------  */
// events
@immutable
abstract class NotificationBlocEvent {}

class GetNotification extends NotificationBlocEvent {}

class OnClickNotification extends NotificationBlocEvent {
  final int index;

  OnClickNotification({required this.index});
}

/* --------------------------------------------------------------------------------------  */
// bloc
class NotificationBloc
    extends Bloc<NotificationBlocEvent, NotificationBlocState> {
  NotificationBloc() : super(NotificationBlocState.initial()) {
    on<GetNotification>((event, emit) async {
      // loading
      emit(NotificationBlocState(isLoading: true, data: [], isError: false));

      // api call
      List<NotificationModel> model = [];
      model.clear();
      model.add(NotificationModel(
          title: "Hey David",
          desc:
              "Create an account and unlock free shipping for your first two orders. Sign up now!",
          isRead: false));
      model.add(NotificationModel(
          title: "Offer Code",
          desc:
              "Alex can receive an offer code ‘ALEX20′ for a 20% discount on their first purchase.",
          isRead: true));
      model.add(NotificationModel(
          title: "Hello",
          desc: "This is the new fad! Have you gotten yours yet? Order now!",
          isRead: false));
      model.add(NotificationModel(
          title: "Hey David",
          desc:
              "Create an account and unlock free shipping for your first two orders. Sign up now!",
          isRead: false));
      model.add(NotificationModel(
          title: "Offer Code",
          desc:
              "Alex can receive an offer code 'ALEX20' for a 20% discount on their first purchase.",
          isRead: false));
      model.add(NotificationModel(
          title: "Hello",
          desc: "This is the new fad! Have you gotten yours yet? Order now!",
          isRead: false));

      // result
      final mod = await ApiClass.instance.getProducts();
      emit(
          NotificationBlocState(isLoading: false, data: model, isError: false));
    });

    on<OnClickNotification>((event, emit) async {
      state.data[event.index].isRead = true;

      // result
      emit(NotificationBlocState(
          isLoading: false, data: state.data, isError: false));
    });
  }
}
