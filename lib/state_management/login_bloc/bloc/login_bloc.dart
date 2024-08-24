import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/auth_methods.dart';
import 'package:tictactoe/utils/http_error_handler.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthMethods authMethods;
  final GameRepository gameRepository;

  LoginBloc({required this.authMethods, required this.gameRepository})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is UserLoginEvent) {
        Data data = await authMethods.login(
            email: event.email, password: event.password);
        if (data.isError) {
          emit(UserLoginFailedState(errorMsg: data.errorData! as String));
          return;
        }
        emit(UserLoggedInState(token: data.successData!["token"]));
        gameRepository.authToken = data.successData!["token"];
        return;
      }
    });
  }
}
