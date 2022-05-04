import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:email_validator/email_validator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState('Enter valid email'));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState('Enter valid password'));
      } else {
        emit(SignInValidState());
      }
    });

    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
