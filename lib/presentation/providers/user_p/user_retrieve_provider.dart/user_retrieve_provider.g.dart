// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_retrieve_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRetrieveHash() => r'81588015453fd42f274c2302f43bf5fdebf36bfe';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$UserRetrieve extends BuildlessAutoDisposeAsyncNotifier<User> {
  late final int id;

  FutureOr<User> build(
    int id,
  );
}

/// See also [UserRetrieve].
@ProviderFor(UserRetrieve)
const userRetrieveProvider = UserRetrieveFamily();

/// See also [UserRetrieve].
class UserRetrieveFamily extends Family<AsyncValue<User>> {
  /// See also [UserRetrieve].
  const UserRetrieveFamily();

  /// See also [UserRetrieve].
  UserRetrieveProvider call(
    int id,
  ) {
    return UserRetrieveProvider(
      id,
    );
  }

  @override
  UserRetrieveProvider getProviderOverride(
    covariant UserRetrieveProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userRetrieveProvider';
}

/// See also [UserRetrieve].
class UserRetrieveProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserRetrieve, User> {
  /// See also [UserRetrieve].
  UserRetrieveProvider(
    int id,
  ) : this._internal(
          () => UserRetrieve()..id = id,
          from: userRetrieveProvider,
          name: r'userRetrieveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userRetrieveHash,
          dependencies: UserRetrieveFamily._dependencies,
          allTransitiveDependencies:
              UserRetrieveFamily._allTransitiveDependencies,
          id: id,
        );

  UserRetrieveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<User> runNotifierBuild(
    covariant UserRetrieve notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(UserRetrieve Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserRetrieveProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserRetrieve, User> createElement() {
    return _UserRetrieveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserRetrieveProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRetrieveRef on AutoDisposeAsyncNotifierProviderRef<User> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UserRetrieveProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserRetrieve, User>
    with UserRetrieveRef {
  _UserRetrieveProviderElement(super.provider);

  @override
  int get id => (origin as UserRetrieveProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
