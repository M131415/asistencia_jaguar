import 'package:asistencia_jaguar/data/http_request_failure.dart';
import 'package:asistencia_jaguar/data/services/remote/03_user_services/user_api.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_retrieve_provider.g.dart';

@riverpod
class UserRetrieve extends _$UserRetrieve {
  final _userService = UserService();

  @override
  FutureOr<User> build(int id) async {
    state = const AsyncValue.loading();
    final result = await _userService.getUserById(id);
    
    return result.when(
      left: (HttpRequestFailure failure) {
        throw Exception(failure.message);
      },
      right: (User user) {
        return user;
      },
    );
  }

  Future<void> getUserById(int id) async {
    state = const AsyncValue.loading();
    final result = await _userService.getUserById(id);
    
    state = result.when(
      left: (HttpRequestFailure failure) => AsyncValue.error(
        failure,
        StackTrace.current,
      ),
      right: (User user) => AsyncValue.data(user),
    );
  }
}