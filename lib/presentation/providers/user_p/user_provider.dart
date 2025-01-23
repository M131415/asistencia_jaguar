import 'package:asistencia_jaguar/data/models/user_list.dart';
import 'package:asistencia_jaguar/data/services/remote/03_user_services/user_api.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final _userService = UserService();

  @override
  Future<List<UserList>> build() async {
    final response = await _userService.getAllUsers();
    return response.when(
      left: (failure) => throw Exception(failure.message),
      right: (users) {
        state = AsyncValue.data(users);
        return users;
      },
    );
  }

  // Get all users
  Future<List<UserList>> getAllUsers() async {
    final response = await _userService.getAllUsers();
    return response.when(
      left: (failure) => [],
      right: (users) {
        state = AsyncValue.data(users);
        return users;
      },
    );
  }

  // Get users by role
  Future<void> getUsersByRole(UserRol rol) async {
    state = const AsyncLoading();
    final response = await _userService.getAllUsersByRol(rol);
    
    response.when(
      left: (failure) => state = AsyncValue.error(failure.message, StackTrace.fromString('error getting users by role')),
      right: (users) {
        state = AsyncValue.data(users);
      },
    );
  }

  // Get user by id
  Future<User> getUserById(int id) async {
    final response = await _userService.getUserById(id);
    return response.when(
      left: (failure) => throw Exception(failure.message),
      right: (user) {
        return user;
      },
    );
  }

  // Create user
  Future<bool> createUser(User user) async {
    state = const AsyncLoading();
    final response = await _userService.createUser(user);
    return response.when(
      left: (failure) => false,
      right: (success) {
        ref.invalidateSelf();
        return success;
      },
    );
  }

  // Update user
  Future<bool> updateUser(int id, User user) async {
    state = const AsyncLoading();
    final response = await _userService.updateUser(id, user);
    return response.when(
      left: (failure) => false,
      right: (success) {
        ref.invalidateSelf();
        return success;
      },
    );
  }

  // Delete user
  Future<bool> deleteUser(int id) async {
    state = const AsyncLoading();
    final response = await _userService.deleteUser(id);
    return response.when(
      left: (failure) => false,
      right: (success) {
        ref.invalidateSelf();
        return success;
      },
    );
  }
}

